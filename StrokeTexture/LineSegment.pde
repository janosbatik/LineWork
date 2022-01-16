class LineSegment
{
  int numSegs = 320;
  float segLen = 1;
  ArrayList<PVector> line = new ArrayList<PVector>();
  PVector start;
  color[] pallet;
  float perturbation = radians(3);
  float yOffset = 40;

  LineSegment(float x, LineSegment neighbour)
  {
    Setup(x);
    for (int i = 0; i < numSegs; i++)
    {
      PVector nSeg = neighbour.line.get(i);
      float rand = randomGaussian();
      float ang = nSeg.heading() + rand* perturbation;
      PVector seg = PVector.fromAngle(ang);
      //println("ang:"+ ang + " per: " + perturbation + " heading: " + nSeg.heading());
      //println( "_");
      seg.setMag(segLen);
      line.add(seg);
    }
  }

  LineSegment(float x)
  {
    Setup(x);

    for (int i = 0; i < numSegs; i++)
    {
      line.add(new PVector(0, segLen));
    }
  }

  void Setup(float x)
  {
    SetPallet();
    start = new PVector(x, yOffset);
  }

  void SetPallet() {
    pallet = new color[4];
    pallet[0] = #F7CACD;
    pallet[1] = #F29CA3;
    pallet[2] = #DE4D86;
    pallet[3] = #64113F;
  }

  void DrawLineSegment()
  {
    //stroke(pallet[int(random(4))]);
    stroke(#000000);
    PVector prev = start.copy();
    PVector next = start.copy();

    for (int i = 0; i < numSegs; i++)
    {
      PVector addVec = line.get(i);
      next.add(addVec);
      line(prev.x, prev.y, next.x, next.y);
    }
  }
}
