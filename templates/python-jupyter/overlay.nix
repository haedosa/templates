final: prev: {


  mypython-packages = p: with p; [
    scipy
    numpy
    tensorflow-bin
    matplotlib
    scikit-learn
    pandas
    lightgbm
    pytorch
    ipympl
    plotly
    seaborn
  ];


  mypython = final.python3.withPackages final.mypython-packages;

  jupyterlab = final.mkJupyterlab {
    pythonPackages = final.mypython-packages;
  };


}
