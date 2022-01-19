ArrayList<BezierLine> bl = new ArrayList<BezierLine>();
color[] pallet;
color background = color(0);
color lineColour = color(255);

int mode = 1; 

int offset = 60;
int spacing = 10;
int numSegs = 10;

void setup()
{
  size(600, 600);
  background(background);
  noFill();
  InitPallet();
  Setup();
}

void Setup()
{
  int segLen = (width-2*offset)/numSegs; 

  for (int y = offset; y <= height-offset; y+=spacing) {
    BezierLine b =  new BezierLine(offset, y, lineColour);
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
    if (mousePressed)
    {
      switch(mode)
      {
        case(1): 
        if (mouseButton == LEFT)
          b.AttractControls();
        else if (mouseButton == RIGHT)
          b.RepelControls();
        break;
        case(2): 
          b.AttractAndRepelControls();
        break;
      }
    } else
      b.ReturnControls();
    //b.DrawAnchors();
    // b.DrawControlPoints();
  }
}

void keyPressed()
{
  // If the key is between 'A'(65) to 'Z' and 'a' to 'z'(122)
  switch(key)
  {
    case('1'): // attractor
    mode = 1;
    println("Mode 1 - Push or Pull");
    break;
    case('2'): // repeller
    mode = 2;
    println("Mode 2 - Push and Pull");
    break;
    case('r'): // rest
    case('R'):
    Reset();
    break;
  }
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

void Reset()
{
  bl = new ArrayList<BezierLine>();
  Setup();
}
