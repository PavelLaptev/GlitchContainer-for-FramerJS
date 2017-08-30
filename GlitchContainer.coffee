class exports.GlitchContainer extends Layer
	constructor: (options={}) ->
		options = _.defaults options,
			width: options.layer.width
			height: options.layer.height
			x: options.layer.x
			y: options.layer.y
			speed: 40
			blink: 0.2
			backgroundColor: null
		super options
		@layer = options.layer ? print "Add a layer"
		@.addChild(@layer)
		@layer.x = 0
		@layer.y = 0
		@speed = options.speed
		@blink = options.blink
		@basicAnimation(@, @layer)
		@stereoGlith = if options.stereoGlith is true
			@stereoGlith(@, @layer, options.stereoOffsetX, options.stereoOffsetY)
		
	#### DEFINE ####		
	@define "stereoOffsetX",
		get: -> if @layerBlue?
			@layerBlue.style.left
			@layerBlue.style.left
		set: (value) -> if @layerBlue?
			@layerBlue.style.left = value + "px"
			@layerRed.style.left = -value + "px"
		
	@define "stereoOffsetY",
		get: -> if @layerBlue?
			@layerBlue.style.top
			@layerRed.style.top
		set: (value) -> if @layerBlue?
			@layerBlue.style.top = value + "px"
			@layerRed.style.top = -value + "px"
		
	#### METHODS ####
	basicAnimation: (parent, layer) ->
		opacityArr = [0.9, 0.98, 1, 0.4, 0.5, 0.8]
		layerCopyA = @layer.copy()
		layerCopyA.props =
			parent: parent
			opacity: 1
			x: 1
			y: 1
		cssKeyframes = """@keyframes noise-anim{0%{clip:rect(40px,9999px,53px,0)}2%{clip:rect(#{Math.round layerCopyA.height/1}px,9999px,#{Math.round layerCopyA.height/2}px,0)}4%{clip:rect(56px,9999px,78px,0)}6%{clip:rect(#{Math.round layerCopyA.height/2}px,9999px,24px,0)}8%{clip:rect(#{Math.round layerCopyA.height/2}px,9999px,1px,0)}10%{clip:rect(26px,9999px,81px,0)}12%{clip:rect(#{Math.round layerCopyA.height/2}px,9999px,63px,0)}14%{clip:rect(39px,9999px,86px,0)}16%{clip:rect(84px,9999px,60px,0)}18%{clip:rect(91px,9999px,67px,0)}20%{clip:rect(66px,9999px,84px,0)}22%{clip:rect(28px,9999px,89px,0)}24%{clip:rect(#{Math.round layerCopyA.height/1.2}px,9999px,76px,0)}26%{clip:rect(58px,9999px,#{Math.round layerCopyA.height/3}px,0)}28%{clip:rect(82px,9999px,97px,0)}30%{clip:rect(27px,9999px,29px,0)}32%{clip:rect(85px,9999px,67px,0)}34%{clip:rect(47px,9999px,98px,0)}36%{clip:rect(92px,9999px,24px,0)}38%{clip:rect(41px,9999px,85px,0)}40%{clip:rect(79px,9999px,71px,0)}42%{clip:rect(#{Math.round layerCopyA.height}px,9999px,#{Math.round layerCopyA.height/2}px,0)}44%{clip:rect(#{Math.round layerCopyA.height/1.3}px,9999px,95px,0)}46%{clip:rect(29px,9999px,41px,0)}48%{clip:rect(66px,9999px,47px,0)}50%{clip:rect(54px,9999px,#{Math.round layerCopyA.height/1.2}px,0)}52%{clip:rect(73px,9999px,61px,0)}54%{clip:rect(56px,9999px,22px,0)}56%{clip:rect(40px,9999px,59px,0)}58%{clip:rect(6px,9999px,78px,0)}60%{clip:rect(69px,9999px,84px,0)}62%{clip:rect(35px,9999px,#{Math.round layerCopyA.height/2}px,0)}64%{clip:rect(78px,9999px,84px,0)}66%{clip:rect(62px,9999px,53px,0)}68%{clip:rect(97px,9999px,46px,0)}70%{clip:rect(55px,9999px,56px,0)}72%{clip:rect(60px,9999px,#{Math.round layerCopyA.height/2}px,0)}74%{clip:rect(19px,9999px,36px,0)}76%{clip:rect(70px,9999px,54px,0)}78%{clip:rect(30px,9999px,67px,0)}80%{clip:rect(21px,9999px,78px,0)}82%{clip:rect(91px,9999px,10px,0)}84%{clip:rect(#{Math.round layerCopyA.height/1.4}px,9999px,40px,0)}86%{clip:rect(45px,9999px,68px,0)}88%{clip:rect(#{Math.round layerCopyA.height/3}px,9999px,4px,0)}90%{clip:rect(#{Math.round layerCopyA.height/1.4}px,9999px,73px,0)}92%{clip:rect(88px,9999px,43px,0)}94%{clip:rect(7px,9999px,53px,0)}96%{clip:rect(9px,9999px,5px,0)}98%{clip:rect(#{Math.round layerCopyA.height/1.2}px,9999px,1px,0)}100%{clip:rect(21px,9999px,#{Math.round layerCopyA.height/1.2}px,0)}}"""
		Utils.insertCSS(cssKeyframes)
		layerCopyA.style = 
			"clip": "rect(40px,9999px,333px,0)"
			"animation": "noise-anim 2s steps(10,end) infinite"
		
		animateRandom = (animLayer) ->
			layer.props =
				scaleX: Utils.randomChoice [1.01, 1.01, 0.99]
				scaleY: Utils.randomChoice [1.1,1.1, 1, 0.99]
				y: Utils.randomChoice [1.2, 1.01, -2]
				x: Utils.randomChoice [1.2, 1.01, -2]
				opacity: Utils.randomChoice opacityArr.map (i) ->
					return i - parent.blink
		
		repeatOften = () ->
			animateRandom(layer)
			globalID = setTimeout ->
				requestAnimationFrame(repeatOften)
			, parent.speed
		
		repeatOften()
		
		return @layerCopyA = layerCopyA
	
	##### --------- #####
	stereoGlith: (parent, layer, stereoOffsetX, stereoOffsetY) ->
		layerBlue = layer.copy()
		layerBlue.props =
			parent: layer
			opacity: 0.8
			x: 1
			y: 1
			name: "layerBlue"
		layerBlue.style = 
			"mix-blend-mode": "screen"
			"filter": "blur(1px) grayscale(100%) brightness(40%) sepia(100%) hue-rotate(-230deg) saturate(700%) contrast(0.8)"
			"left": stereoOffsetX + "px"
			"top": stereoOffsetY + "px"
		layerBlue.sendToBack()
		
		layerRed = layerBlue.copy()
		layerRed.props =
			parent: layer
			opacity: 0.8
			x: -1
			y: -1
			name: "layerRed"
		layerRed.style =
			"mix-blend-mode": "screen"
			"filter": "blur(2px) invert(20%) grayscale(100%) brightness(50%) sepia(100%) hue-rotate(-30deg) saturate(400%) contrast(1.5)"
			"left": -stereoOffsetX + "px"
			"top": -stereoOffsetY + "px"
		layerRed.sendToBack()
		
		layerBlue.style.left = @stereoOffsetX + "px"
		
		opacityArr = [0.9, 0.98, 1, 0.4, 0.5, 0.8]
		arr = []
		arr.push(layer, layerBlue, layerRed)
		
		animateRandom = (animLayers) ->
			animLayers.props =
				scaleX: Utils.randomChoice [1.01, 1.01, 0.99]
				scaleY: Utils.randomChoice [1.1,1.1, 1, 0.99]
				y: Utils.randomChoice [1.2, -2, 1.01, -2]
				x: Utils.randomChoice [1.2, -2, 1.01, -2]
				opacity: Utils.randomChoice opacityArr
		
		repeatOften = () ->
			animateRandom(Utils.randomChoice arr)
			globalID = setTimeout ->
				requestAnimationFrame(repeatOften)
			, parent.speed
		
		repeatOften()
		
		{
			layerBlue: @layerBlue = layerBlue
			layerRed: @layerRed = layerRed
		}
	
	imgNoise: (newNoiseImg) ->
		imgNoiseLayer = new Layer
		imgNoiseLayer.props =
			parent: @
			width: @width
			height: @height
			backgroundColor: null
		noiseImg = newNoiseImg ? """url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIkAAACKCAYAAACesGlnAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyhpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTM4IDc5LjE1OTgyNCwgMjAxNi8wOS8xNC0wMTowOTowMSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTcgKE1hY2ludG9zaCkiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6RDk4QUY0QjE3RDJEMTFFNzlGNDFEN0Q4MUY4QUE2RUEiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6RDk4QUY0QjI3RDJEMTFFNzlGNDFEN0Q4MUY4QUE2RUEiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDpEOThBRjRBRjdEMkQxMUU3OUY0MUQ3RDgxRjhBQTZFQSIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDpEOThBRjRCMDdEMkQxMUU3OUY0MUQ3RDgxRjhBQTZFQSIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/Pi172okAABZ0SURBVHja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')"""
		cssKeyframes = """@keyframes noiseImg-anim{0%{background-position:600px 100px}20%{background-position:200px 400px}40%{background-position:0 -300px}80%{background-position:-700px 40px}100%{background-position:100px -500px}}"""
		Utils.insertCSS(cssKeyframes)
		imgNoiseLayer.style = 
			"background-repeat": "repeat"
			"background-image": noiseImg
			"image-rendering": "pixelated"
			"animation": "noiseImg-anim 2s steps(8,end) infinite"
			"mix-blend-mode": "screen"
	
		return @imgNoiseLayer = imgNoiseLayer