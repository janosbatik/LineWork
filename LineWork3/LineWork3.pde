
ArrayList<Line> lines = new  ArrayList<Line>();
float numLines;
float xOffset = 40;
float yOffset = 40;


void setup()
{
  size(500, 500);
  frameRate(20);
  background(#000000);
  
  PVector oL = new PVector(width/2, height/2);
  PVector oR = oL.copy();
  PVector spacing = new PVector(1, 0);
  numLines =(width - 2*xOffset)/spacing.x+1;
  Line prevL = new Line(oL);
  Line prevR = new Line(oL);
  Line nextLeft; Line nextRight;
  lines.add(prevL);
  for (int i = 1; i < numLines/2; i++)
  {
    oL.sub(spacing);
    oR.add(spacing);
    nextLeft = new Line(oL, prevL);
    nextRight = new Line(oR, prevR);
    lines.add(nextLeft); 
    lines.add(nextRight);
    prevL = nextLeft; 
    prevR = nextRight;
  }

}

void draw()
{
  background(#000000);

  for (Line line : lines)
  {
    line.Draw();
    line.Update();
  }
}
