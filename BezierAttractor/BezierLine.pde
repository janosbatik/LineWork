class BezierLine
{

  ArrayList<BezierSegment> line = new ArrayList<BezierSegment>();
  float xO;
  float yO;

  color lineColour;
  color anchorColour =   color(139, 0, 0);
  color contColour =   color(15);
  float markerDiameter = 2;

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
      bezierVertex(seg.cont1.location.x, seg.cont1.location.y, seg.cont2.location.x, seg.cont2.location.y, seg.xAnchor, seg.yAnchor);
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
      ellipse(seg.cont1.location.x, seg.cont1.location.y, markerDiameter, markerDiameter);
      ellipse(seg.cont2.location.x, seg.cont2.location.y, markerDiameter, markerDiameter);
    }
  }


  void AttractControls()
  {
    for (BezierSegment seg : line)
      seg.AttractToMouse();
  }

  void ReturnControls()
  {
    for (BezierSegment seg : line)
      seg.ReturnToO();
  }
}



class BezierSegment
{
  float xAnchor;
  float yAnchor;
  PVector oCont1;
  PVector oCont2;
  Attractor cont1;
  Attractor cont2;

  BezierSegment(float _xAnchor, float _yAnchor, float _xCont1, float _yCont1, float _xCont2, float _yCont2)
  {
    xAnchor = _xAnchor;
    yAnchor = _yAnchor;

    cont1 = new Attractor(_xCont1, _yCont1);
    cont2 = new Attractor(_xCont2, _yCont2);

    oCont1 = new PVector(_xCont1, _yCont1);
    oCont2 = new PVector(_xCont2, _yCont2);
  }

  void AttractToMouse()
  {
    cont1.AttractToMouse();
    cont2.AttractToMouse();
  }

  void ReturnToO()
  {
    cont1.AttractToPoint(oCont1);
    cont2.AttractToPoint(oCont2);
  }
}
