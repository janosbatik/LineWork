
ArrayList<LineSegment> lines = new  ArrayList<LineSegment>();
float numLines;
float offset = 40;
float  spacing = 3;

void setup()
{
  size(400, 400);
  frameRate(2);
  numLines = (width - 2*offset)/spacing+1;
  background(#000000);
  LineSegment prev = new LineSegment(offset);
  LineSegment next;
  lines.add(prev);
  for (int i = 1; i < numLines; i++)
  {
    next = new LineSegment(i*spacing+offset, prev);
    lines.add(next);
    next.Draw();
    prev = next;
  }
}

void draw()
{
  background(#000000);

  for (LineSegment line : lines)
  {
    line.Draw();
    line.Update();
  }
}
