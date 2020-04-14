############################################################################
#  This Python file is part of PyFEM, the code that accompanies the book:  #
#                                                                          #
#    'Non-Linear Finite Element Analysis of Solids and Structures'         #
#    R. de Borst, M.A. Crisfield, J.J.C. Remmers and C.V. Verhoosel        #
#    John Wiley and Sons, 2012, ISBN 978-0470666449                        #
#                                                                          #
#  The code is written by J.J.C. Remmers, C.V. Verhoosel and R. de Borst.  #
#                                                                          #
#  The latest stable version can be downloaded from the web-site:          #
#     http://www.wiley.com/go/deborst                                      #
#                                                                          #
#  A github repository, with the most up to date version of the code,      #
#  can be found here:                                                      #
#     https://github.com/jjcremmers/PyFEM                                  #
#                                                                          #
#  The code is open source and intended for educational and scientific     #
#  purposes only. If you use PyFEM in your research, the developers would  #
#  be grateful if you could cite the book.                                 #  
#                                                                          #
#  Disclaimer:                                                             #
#  The authors reserve all rights but do not guarantee that the code is    #
#  free from errors. Furthermore, the authors shall not be liable in any   #
#  event caused by the use of the program.                                 #
############################################################################

input = "biaxial_test.dat";

ContElem =
{
  type = "SmallStrainContinuum";

  material =
  {
    type = "IsotropicKinematicHardening";
    E    = 1.e6;
    nu   = 0.25;
    syield = 10000.;
    hard  = 1.e4;
  };
};

solver =
{
  type     = "NonlinearSolver";
  maxCycle = 40;

  dtime    = 1.0;

  loadCases = ["loadCase1","loadCase2"];

  loadCase1 =
  {
    nodeTable = "nodes1";
    loadFunc  = "t*(t<20.)+20.0*(t>=20.)";
  };

  loadCase2 =
  {
    nodeTable = "nodes2";
    loadFunc  = "(t-20.0)*(t>=20.)";
  };
};

outputModules = ["vtk","graph"];

vtk =
{
  type = "MeshWriter";
};

graph =
{
  type = "GraphWriter";
  onScreen = true;

  columns = [ "disp" , "load" ];

  disp =
  {
    type = "state";
    node = 4;
    dof  = "v";
  };

  load =
  {
    type = "fint";
    node = 4;
    dof  = "v";
  };
};
