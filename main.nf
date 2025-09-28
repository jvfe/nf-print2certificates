process FOO {
  container 'community.wave.seqera.io/library/pillow:8.4.0--f2b8dd7ddc55c40e'
  publishDir 'output', mode: 'copy'
  tag "${participant_name}"

  input:
  val participant_name
  tuple val(x), val(y)
  path font
  path template

  output:
  path "${participant_name.replace(" ", "")}.png"

  script:
  """
  #!/opt/conda/bin/python3

  from PIL import Image, ImageFont, ImageDraw

  FONT_FILE = ImageFont.truetype(r'GochiHand-Regular.ttf', 100)
  FONT_COLOR = "#000000"
  WIDTH, HEIGHT = ${x}, ${y}


  def make_cert(name):
      image_source = Image.open(r'certificate_template.png')
      draw = ImageDraw.Draw(image_source)
      name_width, name_height = draw.textsize(name, font=FONT_FILE)
      draw.text((WIDTH-name_width/2, HEIGHT-name_height/2), name, fill=FONT_COLOR, font=FONT_FILE)
      image_source.save(name.replace(" ", "") + ".png")
      print('printing certificate of: '+name)

  make_cert('${participant_name.replace("'", "\\'")}')
  """
}

workflow {
  Channel
    .fromPath(params.names)
    .splitText { it.trim() }
    .set { participant_names }
  FOO(participant_names,
      Channel.of([params.x, params.y]).first(),
      Channel.fromPath(params.font).first(),
      Channel.fromPath(params.template).first())
}
