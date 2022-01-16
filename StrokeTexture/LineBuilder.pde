class LineBuilder
{
  int numSegs = 320;
  float segLen = 1;
  ArrayList<PVector> line = new ArrayList<PVector>();
  PVector o;
  LineBuilder neighbour;
  color[] pallet;
  float perturbation = radians(3);

  LineBuilder(PVector _o, int len, LineBuilder _neighbour)
  {
    Setup(_o, len, _neighbour);
    for (int i = 0; i < numSegs; i++)
    {
      PVector nSeg = _neighbour.line.get(i);
      float rand = randomGaussian();
      float ang = nSeg.heading() + rand* perturbation;
      PVector seg = PVector.fromAngle(ang);
      seg.setMag(segLen);
      line.add(seg);
    }
  }

  LineBuilder(PVector _o, int len)
  {
    Setup(_o, len, null);

    for (int i = 0; i < numSegs; i++)
    {
      line.add(new PVector(0, segLen));
    }
  }

  void Setup(PVector _o, int len, LineBuilder _neighbour)
  {
    SetPallet();
    o = _o;
    numSegs = len;
    neighbour = _neighbour;
  }

  void SetPallet() {
    pallet = new color[4];
    pallet[0] = #F7CACD;
    pallet[1] = #F29CA3;
    pallet[2] = #DE4D86;
    pallet[3] = #64113F;
  }

  void Draw()
  {
    stroke(#000000);
    PVector prev = o.copy();
    PVector next = o.copy();

    for (int i = 0; i < numSegs; i++)
    {
      PVector addVec = line.get(i);
      next.add(addVec);
      line(prev.x, prev.y, next.x, next.y);
    }
  }

  void Update(float spacing)
  {
    if (neighbour != null)
    {
      o.x = neighbour.o.x + spacing;
      PVector nSeg = neighbour.line.get(0);
      float ang = nSeg.heading() + randomGaussian()* perturbation;
      PVector seg = PVector.fromAngle(ang);
      seg.setMag(segLen);
      line.add(0, seg);
      line.remove(numSegs);
    }
  }
}
