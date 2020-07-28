self: super:

{
  ncmpcpp = super.ncmpcpp.override {
    visualizerSupport = true;
    fftw = super.fftw;
  };
}
