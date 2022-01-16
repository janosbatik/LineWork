
ArrayList<LineBuilder> lines = new  ArrayList<LineBuilder>();
float numLines;
int offset = 40;
PVector o;
PVector spacing;
int minSpacing  = 4;
int maxSpacing = 18;

void setup()
{

  size(400, 400);
  background(#BADEFC); 
  o = new PVector(offset, offset);
  spacing = new PVector(minSpacing, 0);
  numLines = NumLines(minSpacing);

  LineBuilder prev = new LineBuilder(o.copy(), height-2*offset);
  LineBuilder next;
  lines.add(prev);
  for (int i = 0; i < numLines; i++)
  {
    o.add(spacing);
    next = new LineBuilder(o.copy(), height-2*offset, prev);
    lines.add(next);
    prev = next;
  }
}

void draw()
{
  background(#BADEFC); 
  float  spacing = map(mouseX, 0, width, minSpacing, maxSpacing);
  numLines = NumLines(spacing);
  for (int i = 0; i < numLines; i++)
  {
    LineBuilder line = lines.get(i);
    line.Update(spacing);
    line.Draw();
  }
}

int NumLines(float spacing)
{
  return ceil((width - 2*offset)/spacing);
}
