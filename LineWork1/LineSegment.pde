class LineSegment
{
  int numSegs;
  ArrayList<PVector> line = new ArrayList<PVector>();
  PVector start;
  LineSegment neighbour;
  float[] updateRot;

  float yOffset = 40;
  int len = 320;
  float segLen = 10;

  color[] pallet;
  boolean USE_PALLET = true;
  color col;
  color DEFAULT_COL =  #FFFFFF;



  float stdDivPerturbation = radians(4);
  //float stdDivUpdatePerturbation = radians(1);

  LineSegment(float x, LineSegment _neighbour)
  {
    Setup(x, _neighbour);
    for (int i = 0; i < numSegs; i++)
    {
      PVector nSeg = _neighbour.line.get(i);
      float rand = randomGaussian();
      float ang = nSeg.heading() + rand* stdDivPerturbation;
      PVector seg = PVector.fromAngle(ang);
      seg.setMag(segLen);
      line.add(seg);
    }
  }

  LineSegment(float x)
  {
    Setup(x, null);
    float rand = randomGaussian();
    float ang = rand* stdDivPerturbation;
    line.add(new PVector(0, segLen));
    for (int i = 1; i < numSegs; i++)
    {
      PVector prev = line.get(i-1);
      rand = randomGaussian();
      ang = prev.heading() + rand* stdDivPerturbation;
      PVector seg = PVector.fromAngle(ang);
      seg.setMag(segLen);
      line.add(seg);
    }
  }

  void Setup(float x, LineSegment _neighbour)
  {
    SetPallet();
    col = PickColour();
    neighbour = _neighbour;
    start = new PVector(x, yOffset);
    numSegs = int(len/segLen);
    updateRot = new float[numSegs];
    for (int i = 0; i < numSegs; i++)
      updateRot[i] = 0;
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
    stroke(col);
    //stroke(#000000);
    PVector prev = start.copy();
    PVector next = start.copy();
    for (int i = 0; i < numSegs; i++)
    {
      PVector addVec = line.get(i);
      next = PVector.add(prev, addVec);
      line(prev.x, prev.y, next.x, next.y);
      prev = next;
    }
  }

  void Update()
  {
    float ang;

    for (int i = 1; i < numSegs; i++)
    {
      PVector seg = line.get(i);
      if (neighbour == null)
      {
        ang = randomGaussian()* stdDivPerturbation;
      } else
      {
        ang = neighbour.updateRot[i] + randomGaussian()* radians(1);
      }
      seg.rotate(ang );
      updateRot[i] = ang;
    }
  }

  float Sign(float n)
  {
    return n/abs(n);
  }


  color PickColour()
  {
    if (USE_PALLET)
      return pallet[int(random(4))];
    else 
    return DEFAULT_COL;
  }
}
