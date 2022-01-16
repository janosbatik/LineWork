class Line
{
  int numSegs;
  ArrayList<PVector> line = new ArrayList<PVector>();
  PVector o;
  Line neighbour;
  float[] updateRot;
  float direction[];

  int len = 420;
  float segLen = 6;

  color[] pallet;
  boolean USE_PALLET = true;
  color col;
  color darken = color(10, 10, 10);
  color DEFAULT_COL =  #FFFFFF;



  float stdDivRotationPerturbation = radians(4);
  float stdDivOriginPerturbation = 1;
  //float stdDivUpdatePerturbation = radians(1);

  Line(PVector _o, Line _neighbour)
  {
    Setup(_o, _neighbour);
    for (int i = 0; i < numSegs; i++)
    {
      PVector nSeg = _neighbour.line.get(i);
      float rand = randomGaussian();
      float ang = nSeg.heading() + rand* stdDivRotationPerturbation;
      PVector seg = PVector.fromAngle(ang);
      direction[i] = i % 2 == 0 ? 1 : 1;
      seg.setMag(direction[i]*segLen);

      line.add(seg);
    }
  }

  Line(PVector _o)
  {
    Setup(_o, null);
    for (int i = 0; i < numSegs; i++)
    {
      direction[i] = i % 2 == 0 ? 1 : -1;
      line.add(new PVector(0, direction[i] * segLen));
    }
    /*
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
     */
  }

  void Setup(PVector _o, Line _neighbour)
  {
    SetPallet();
    col = PickColour();

    neighbour = _neighbour;
    o = _o.copy();

    numSegs = int(len/segLen);
    updateRot = new float[numSegs];
    direction = new float[numSegs];
    for (int i = 0; i < numSegs; i++)
      updateRot[i] = 0;
  }

  void SetPallet() {
    pallet = new color[4];
    pallet[0] = #F7CACD;//color(239, 202, 205);
    pallet[1] = #F29CA3;
    pallet[2] = #DE4D86;
    pallet[3] = #64113F;
  }

  void Draw()
  {
    DrawHalf(0);
    DrawHalf(1);
  }

  void DrawHalf(int startIndex)
  {
    stroke(col);
    PVector prev = o.copy();
    PVector next = o.copy();
    for (int i = startIndex; i < numSegs; i+=2)
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
    PVector rand = new PVector (randomGaussian() *stdDivOriginPerturbation, randomGaussian()*stdDivOriginPerturbation);
    o.add(rand);
    for (int i = 0; i < numSegs; i++)
    {
      PVector seg = line.get(i);
      if (neighbour == null)
      {
        ang = randomGaussian()* stdDivRotationPerturbation;
      } else
      {
        ang = neighbour.updateRot[i] + randomGaussian()* radians(1);//stdDivRotationPerturbation;
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
