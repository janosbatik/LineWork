class Path
{
  int numSegs;
  ArrayList<Point> points = new ArrayList<Point>();

  color[] pallet;
  boolean USE_PALLET = true;
  color col;
  color DEFAULT_COL =  #FFFFFF;


  Path()
  {
    Setup();
  }

  void AddPoint(PVector point)
  {
    points.add(point);
  }

  void Setup()
  {
    SetPallet();
    col = PickColour();
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
    PVector prev = o.copy();
    PVector next = o.copy();
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

class Point
{
  PVector attractor;
  PVector location;
  PVector velocity;
  PVector acceleration;
 
}
