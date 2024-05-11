extends Control
# this is a shit script dont look at it. it is the simples form and i might remake it in the future but for testing this was faster to make. sue me
var img1: TextureRect
var img2: TextureRect
var img3: TextureRect

var imgy1: TextureRect
var imgy2: TextureRect
var imgy3: TextureRect

var imga1: TextureRect
var imga2: TextureRect
var imga3: TextureRect

func _ready():
	img1 = get_node("TextureRect1")
	img2 = get_node("TextureRect2")
	img3 = get_node("TextureRect3")

	imgy1 = get_node("TextureRecty1")
	imgy2 = get_node("TextureRecty2")
	imgy3 = get_node("TextureRecty3")

	imga1 = get_node("TextureRecta1")
	imga2 = get_node("TextureRecta2")
	imga3 = get_node("TextureRecta3")

func _process(delta):
	if img1.position.x < -1920:
		img1.position.x = 1920
		imgy1.position.x = 1920
		imga1.position.x = 1920
	if img2.position.x < -1920:
		img2.position.x = 1920
		imgy2.position.x = 1920
		imga2.position.x = 1920
	if img3.position.x < -1920:
		img3.position.x = 1920
		imgy3.position.x = 1920
		imga3.position.x = 1920

	
	img1.position.x -= 0.6
	img2.position.x -= 0.6
	img3.position.x -= 0.6
	imgy1.position.x -= 0.6
	imgy2.position.x -= 0.6
	imgy3.position.x -= 0.6
	imga1.position.x -= 0.6
	imga2.position.x -= 0.6
	imga3.position.x -= 0.6


	if img1.position.y > 1080:
		img1.position.y = -1080
		img2.position.y = -1080
		img3.position.y = -1080
	if imgy1.position.y > 1080:
		imgy1.position.y = -1080
		imgy2.position.y = -1080
		imgy3.position.y = -1080
	if imga1.position.y > 1080:
		imga1.position.y = -1080
		imga2.position.y = -1080
		imga3.position.y = -1080
	
	img1.position.y += 0.5
	img2.position.y += 0.5
	img3.position.y += 0.5
	imgy1.position.y += 0.5
	imgy2.position.y += 0.5
	imgy3.position.y += 0.5
	imga1.position.y += 0.5
	imga2.position.y += 0.5
	imga3.position.y += 0.5
