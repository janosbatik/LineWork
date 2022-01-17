ArrayList<BezierLine> bl = new ArrayList<BezierLine>();
color[] pallet;
color background = #E0DDCF;

void setup()
{
  size(400, 400);
  background(background);
  noFill();
  InitPallet();
  int offset = 40;
  int spacing = 10;
  int len = height-offset;
  int numSegs = 10;
  int segLen = len/numSegs; 

  for (int y = offset; y < len; y+=spacing) {
    BezierLine b =  new BezierLine(offset, y, SomeColor());
    for (int i = 1; i < numSegs; i++) 
    {
      b.AddSegment(offset + i*segLen, y, offset + i*segLen*0.5, y-spacing*0.3, offset + i*segLen*0.5, y+spacing*0.3);
    }
    bl.add(b);
  }
}
void draw()
{
  background(background);
  for (BezierLine b : bl)
  {
    b.Draw();
   // b.DrawAnchors();
   // b.DrawControlPoints();
    for (int i = 0; i < b.line.size(); i++)
    {
      b.AdjustControls(i, Pert(), Pert(), Pert(), Pert());
    }
  }
}

float Pert()
{
  return random(-1, 1);
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
