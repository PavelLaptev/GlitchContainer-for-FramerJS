{GlitchContainer} = require 'GlitchContainer'

Framer.Extras.Hints.disable()

layerC = new Layer
	width: 134
	height: 105
	x: 190
	y: 38
	borderRadius: 14
	image: Utils.randomImage()

#*******************************#
####### GLITCH CONTAINERS #######
#*******************************#

glitchA = new GlitchContainer
	layer: glitch_text
	speed: 40
	stereoGlith: true
	blink: 0.6

glitchA.imgNoise()

glitchB = new GlitchContainer
	layer: ric1
	stereoGlith: true
	speed: 40
	
glitchB.imgNoise()

glitchC = new GlitchContainer
	layer: layerC
	stereoGlith: true

glitchC.imgNoise()
glitchC.draggable = true


#*******************************#
########### CONTROLS ############
#*******************************#

sliderStereoX = new SliderComponent
	width: 130
	y: 353
	x: 204
	min: 2
	max: 100
	
sliderStereoX.on "change:value", ->
	glitchA.stereoOffsetX = @value
	glitchC.stereoOffsetX = @value

sliderStereoY = new SliderComponent
	width: 130
	y: 404
	x: 204
	min: 2
	max: 100

sliderStereoY.on "change:value", ->
	glitchA.stereoOffsetY = @value
	glitchC.stereoOffsetY = @value

sliderBlink = new SliderComponent
	y: 526
	x: Align.center()
	knobSize: 30
	min: 0.1
	max: 0.9
	
sliderBlink.on "change:value", ->
	glitchA.blink = @value
	glitchC.blink = @value
	
sliderSpeed = new SliderComponent
	y: 473
	x: Align.center()
	knobSize: 30
	min: 20
	max: 1000

sliderSpeed.on "change:value", ->
	glitchA.speed = @value
	glitchC.speed = @value

sliderNIW = new SliderComponent
	width: 130
	y: 591
	x: 204
	min: 90
	max: 1000
	
sliderNIW.on "change:value", ->
	glitchA.imgNoiseLayer.style.height = @value + "px"
	glitchC.imgNoiseLayer.style.height = @value + "px"

noiseCheck.onTap ->
	if noiseCheckEl.opacity is 1
		noiseCheckEl.opacity = 0
		glitchA.imgNoiseLayer.opacity = 0
		glitchC.imgNoiseLayer.opacity = 0
	else
		noiseCheckEl.opacity = 1
		glitchA.imgNoiseLayer.opacity = 1
		glitchC.imgNoiseLayer.opacity = 1