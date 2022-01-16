
ArrayList<LineSegment> lines = new  ArrayList<LineSegment>();
float numLines;
float offset = 40;
//float spaceing = 15;

void setup()
{
  size(400, 400);
  //background(#84E6F8); // light blue
  
  //background(#FFFFFF);
  

}

void draw()
{
 // for (LineSegment ls : lines)
 //   ls.DrawLineSegment();
 float  spaceing = map(mouseX, 0, width, 4,18);
 numLines = (width - 2*offset)/spaceing+1;
   background(#BADEFC); 
   LineSegment prev = new LineSegment(offset);
  LineSegment next;
  lines.add(prev);
  for (int i = 0; i < numLines; i++)
  {
    next = new LineSegment(i*spaceing+offset, prev);
    lines.add(next);
    next.DrawLineSegment();
    prev = next;
 }
}
