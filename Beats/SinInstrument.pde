public class SinInstrument
{
  private SinNote[] notes;

  public SinInstrument(SinNote... notes)
  {
    this.notes = new SinNote[notes.length];
    for (int i = 0; i < notes.length; i++)
    {
      this.notes[i] = notes[i];
    }
  }

  public void play()
  {
    for (int i = 0; i < notes.length; i++)
    {
      if (keyCode == notes[i].getCode())
        notes[i].play();
    }
  }

  public void stop()
  {
    for (int i = 0; i < notes.length; i++)
    {
      if (keyCode == notes[i].getCode())
        notes[i].stop();
    }
  }
}

class SinNote
{
  private SinOsc osc;
  private float frequency;
  private int code;
  private boolean isPlaying = false;

  public SinNote(float frequency, int code)
  {
    osc = new SinOsc(Beats.this);
    setFrequency(frequency);
    setCode(code);
  }

  public float getFrequency()
  {
    return frequency;
  }

  public void setFrequency(float frequency)
  {
    this.frequency = frequency;
  }

  public int getCode()
  {
    return code;
  }

  public void setCode(int code)
  {
    this.code = code;
  }

  public void play()
  {
    if (!isPlaying)
    {
      osc.play(frequency, 0.5);
      isPlaying = true;
    }
  }

  public void stop()
  {
    if (isPlaying)
    {
      osc.stop();
      isPlaying = false;
    }
  }
}
