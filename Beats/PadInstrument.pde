public class PadInstrument
{
  private Sound[] sounds;

  public PadInstrument(Sound... sounds)
  {
    this.sounds = new Sound[sounds.length];
    for (int i = 0; i < sounds.length; i++)
    {
      this.sounds[i] = sounds[i];
    }
  }

  public void play()
  {
    for (int i = 0; i < sounds.length; i++)
    {
      if (keyCode == sounds[i].getCode())
        sounds[i].play();
    }
  }
  
  public void stop()
  {
    for (int i = 0; i < sounds.length; i++)
    {
      if (keyCode == sounds[i].getCode())
        sounds[i].stop();
    }
  }
}

class Sound
{
  private SoundFile sound;
  private int code;

  public Sound(String filePath, int code)
  {
    setSound(filePath);
    setCode(code);
  }

  public SoundFile getSound()
  {
    return sound;
  }

  public void setSound(String filePath)
  {
    sound = new SoundFile(Beats.this, filePath);
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
    sound.play();
  }

  public void stop()
  {
    sound.stop();
  }
}