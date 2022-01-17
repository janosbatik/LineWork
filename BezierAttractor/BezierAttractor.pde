ArrayList<BezierLine> bl = new ArrayList<BezierLine>();
color[] pallet;
color background = color(255);
boolean attractControls = false;

void setup()
{
  size(600, 600);
  background(background);
  noFill();
  InitPallet();
  int offset = 60;
  int spacing = 10;
  int numSegs = 10;
  int segLen = (width-2*offset)/numSegs; 

  for (int y = offset; y <= height-offset; y+=spacing) {
    BezierLine b =  new BezierLine(offset, y, color(0));
    for (int x = segLen + offset; x <= width-offset; x+=segLen) 
      b.AddSegment(x, y, x - segLen*0.5, y-spacing*0.3, x - segLen*0.5, y+spacing*0.3);
    bl.add(b);
  }
}
void draw()
{
  background(background);
  for (BezierLine b : bl)
  {
    b.Draw();
    if (attractControls)
      b.AttractControls();
    else
      b.ReturnControls();
    //b.DrawAnchors();
    // b.DrawControlPoints();
  }
}

void mousePressed() {
  attractControls = true;
}

void mouseReleased() {
  attractControls = false;
}

void InitPallet()
{
  pallet = new color[3]; 
  pallet[0] = #474448;
  pallet[1] = #2D232E;
  pallet[2] = #3A343B;
}

color SomeColor()
{
  int pick = floor(random(pallet.length));
  return pallet[pick];
}
