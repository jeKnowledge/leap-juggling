package 
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Point;
    import flash.net.URLRequest;
    import flash.utils.Dictionary;
    
    /**
     * Creates Sprites from previously loaded in Bitmaps.
     * You may create any number of Sprites from a single Bitmap.
     * 
     * @example The following code shows basic usage:
     * <listing version="3.0">
     * var factory:SpriteFactory = new SpriteFactory();
     * factory.loadBitmap("tree", "tile-tree.png");
     * 
     * // Create a tree sprite with its origin at the top-left corner.
     * var tree:Sprite = factory.newInstance("tree");    
     * </listing>
     * 
     * @example The following code shows advanced usage:
     * <listing version="3.0">
     * var factory:SpriteFactory = new SpriteFactory("assets/sprites");
     * factory.loadBitmap("tree", "tile-tree.png");
     * 
     * // Create a tree sprite with its origin at the middle.
     * var tree:Sprite = factory.newInstance("tree", 
     *     SpriteFactory.HALIGN_CENTER | SpriteFactory.VALIGN_MIDDLE);
     * </listing>
     * 
     * Copyright (c) 2010, Cameron McKay
     * All rights reserved.
     *
     * Redistribution and use in source and binary forms, with or without
     * modification, are permitted provided that the following conditions are met:
     *     - Redistributions of source code must retain the above copyright
     *       notice, this list of conditions and the following disclaimer.
     *     - Redistributions in binary form must reproduce the above copyright
     *       notice, this list of conditions and the following disclaimer in the
     *       documentation and/or other materials provided with the distribution.
     *     - Neither the name of the <organization> nor the
     *       names of its contributors may be used to endorse or promote products
     *       derived from this software without specific prior written permission.
     *
     * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
     * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
     * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
     * DISCLAIMED. IN NO EVENT SHALL CAMERON MCKAY BE LIABLE FOR ANY
     * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
     * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
     * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
     * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
     * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
     * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
     * 
     * @author Cameron McKay
     */
    public class SpriteFactory
    {                
        public static const HALIGN_LEFT:uint   = 1;
        public static const HALIGN_CENTER:uint = 2;
        public static const HALIGN_RIGHT:uint  = 4;        
        public static const VALIGN_TOP:uint    = 8;
        public static const VALIGN_MIDDLE:uint = 16;
        public static const VALIGN_BOTTOM:uint = 32;
        
        private var _path:String;
        private var _bitmaps:Dictionary = new Dictionary();
        private var _queues:Dictionary  = new Dictionary();
        
        /**
         * Create a new sprite factory that reads bitmaps
         * from an optional path.
         * 
         * @param    path The path to look for bitmaps.
         */
        public function SpriteFactory(path:String = "") {
            _path = path;            
        }
        
        /**
         * Create a new sprite using the given bitmap id.
         * 
         * @param    id The id used to load the bitmap.
         * @param    alignment The alignment of the bitmap relative to sprite origin.
         * @return  A new sprite with bitmap in it.
         */
        public function newSprite(id:String, alignment:uint = 0):Sprite {
            if (!_bitmaps.hasOwnProperty(id)) {
                throw new ArgumentError("Bitmap id not found: " + id);
            }
                                            
            var sprite:Sprite = new Sprite();            
            var bitmap:Bitmap = _bitmaps[id];                                        
            if (bitmap === null) {
                _queues[id] = _queues[id] || [];
                _queues[id].push({
                    sprite: sprite,
                    alignment: alignment
                });
            }
            else {                
                var clone:Bitmap = new Bitmap(bitmap.bitmapData);
                var offset:Point = calculateOffset(alignment, bitmap);
                clone.x = offset.x;
                clone.y = offset.y;
                sprite.addChild(clone);
            }
            
            return sprite;
        }
        
        /**
         * Load a bitmap from a file.
         * 
         * @param    id The unique identifier to be used when creating a sprite.
         * @param    filename The name of the file.
         */
        public function loadBitmap(id:String, filename:String):void {
            if (_bitmaps.hasOwnProperty(id)) {
                throw new ArgumentError("Bitmap id must be unique: " + id);
            }
                        
            _bitmaps[id] = null;
                        
            var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {                
                var bitmap:Bitmap = e.target.content;
                var bitmapData:BitmapData = bitmap.bitmapData;
                
                trace("Finished loading " + id);                
                
                var queue:Array = _queues[id];
                if (queue && queue.length > 0) {                    
                    for (var i:int = 0; i < queue.length; i++) {    
                        var o:Object = queue[i];
                        var clone:Bitmap = new Bitmap(bitmapData);
                        var offset:Point = calculateOffset(o.alignment, clone);
                        clone.x = offset.x;
                        clone.y = offset.y;
                        o.sprite.addChild(clone);
                    }
                    delete _queues[id];
                }
            });
            
            trace("Started loading " + id);
            var url:String = _path + "/" + filename;
            loader.load(new URLRequest(url));
        }
        
        /**
         * Calculate the Cartesian offsets needed to align
         * a bitmap according to a given alignment.
         * 
         * @param    alignment An alignment mask.
         * @param    bitmap The bitmap that is being aligned.
         * @return  The point that the top-left corner of the bitmap should be.
         */
        private function calculateOffset(alignment:uint, bitmap:Bitmap):Point {
            var offset:Point = new Point(0, 0);                            
            
            if ((alignment & HALIGN_CENTER) === HALIGN_CENTER) {                
                offset.x = -bitmap.width / 2;
            }
            else if ((alignment & HALIGN_RIGHT) === HALIGN_RIGHT) {
                offset.x = -bitmap.width;
            }
            
            if ((alignment & VALIGN_MIDDLE) === VALIGN_MIDDLE) {                
                offset.y = -bitmap.height / 2;
            }
            else if ((alignment & VALIGN_BOTTOM) === VALIGN_BOTTOM) {
                offset.y = -bitmap.height;
            }
                        
            return offset;
        }
        
    }
}