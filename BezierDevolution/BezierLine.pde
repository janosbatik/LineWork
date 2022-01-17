class BezierLine
{

  ArrayList<BezierSegment> line = new ArrayList<BezierSegment>();
  float xO;
  float yO;

  color lineColour;
  color anchorColour =   color(139, 0, 0);
  color contColour =   color(0, 0, 139);
  float markerDiameter = 5;

  BezierLine (float x, float y, color col)
  {
    xO = x;
    yO = y;
    lineColour = col;
  }

  BezierLine (PVector start) 
  {
    this(start.x, start.y);
  }

  BezierLine (float x, float y) 
  {
    this(x, y, color(0));
  }

  void AddSegment(PVector anchor, PVector cont1, PVector cont2)
  {
    line.add(new BezierSegment(anchor.x, anchor.y, cont1.x, cont1.y, cont2.x, cont2.y));
  }

  void AddSegment(float xAnchor, float yAnchor, float xCont1, float yCont1, float xCont2, float yCont2)
  {
    line.add(new BezierSegment(xAnchor, yAnchor, xCont1, yCont1, xCont2, yCont2));
  }

  void Draw()
  {
    if (line.size()<1)
    {
      println("you must add segments to BezierLine before drawing");
      return;
    }
    BezierSegment seg;
    beginShape();
    stroke(lineColour);
    vertex(xO, yO);
    for (int i = 0; i < line.size(); i++)
    {
      seg = line.get(i);
      bezierVertex(seg.xCont1, seg.yCont1, seg.xCont2, seg.yCont2, seg.xAnchor, seg.yAnchor);
    }
    endShape();
  }

  void DrawAnchors()
  {
    noFill();
    stroke(anchorColour);
    ellipse(xO, yO, markerDiameter, markerDiameter);
    for (BezierSegment seg : line)
      ellipse(seg.xAnchor, seg.yAnchor, markerDiameter, markerDiameter);
  }

  void DrawControlPoints()
  {
    noFill();
    stroke(contColour);
    for (BezierSegment seg : line)
    {
      ellipse(seg.xCont1, seg.yCont1, markerDiameter, markerDiameter);
      ellipse(seg.xCont2, seg.yCont2, markerDiameter, markerDiameter);
    }
  }
  void UpdateControls(int index, float xCont1, float yCont1, float xCont2, float yCont2)
  {
    BezierSegment seg = line.get(index);
    seg.xCont1 = xCont1;
    seg.yCont1 = yCont1; 
    seg.xCont2 = xCont2; 
    seg.yCont2 = yCont2;
  }

  void AdjustControls(int index, float xCont1, float yCont1, float xCont2, float yCont2)
  {
    BezierSegment seg = line.get(index);
    seg.xCont1 += xCont1;
    seg.yCont1 += yCont1; 
    seg.xCont2 += xCont2; 
    seg.yCont2 += yCont2;
  }

  void UpdateAnchor(int index, float xAnchor, float yAnchor)
  {
    if (index == 0)
    {
      xO = xAnchor;
      yO = yAnchor;
    } else
    {
      BezierSegment seg = line.get(index);
      seg.xAnchor = xAnchor;
      seg.yAnchor= yAnchor;
    }
  }
}



class BezierSegment
{
  float xAnchor; 
  float yAnchor; 
  float xCont1; 
  float yCont1; 
  float xCont2; 
  float yCont2;

  BezierSegment(float _xAnchor, float _yAnchor, float _xCont1, float _yCont1, float _xCont2, float _yCont2)
  {
    xAnchor = _xAnchor;
    yAnchor= _yAnchor; 
    xCont1 = _xCont1; 
    yCont1 = _yCont1; 
    xCont2 = _xCont2; 
    yCont2 = _yCont2;
  }
}
