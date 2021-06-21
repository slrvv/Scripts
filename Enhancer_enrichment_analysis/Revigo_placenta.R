# A plotting R script produced by the REVIGO server at http://revigo.irb.hr/
# If you found REVIGO useful in your work, please cite the following reference:
# Supek F et al. "REVIGO summarizes and visualizes long lists of Gene Ontology
# terms" PLoS ONE 2011. doi:10.1371/journal.pone.0021800

# --------------------------------------------------------------------------
# If you don't have the ggplot2 package installed, uncomment the following line:
# install.packages( "ggplot2" );
library( ggplot2 );
library(ggrepel)
# --------------------------------------------------------------------------
# If you don't have the scales package installed, uncomment the following line:
# install.packages( "scales" );
library( scales );

# --------------------------------------------------------------------------
# Here is your data from REVIGO. Scroll down for plot configuration options.

revigo.names <- c("term_ID","description","frequency_%","plot_X","plot_Y","plot_size","value","uniqueness","dispensability");
revigo.data <- rbind(c("GO:0010975","regulation of neuron projection development",2.434,-1.977,-7.342,2.638,-7.853,0.936,0.000),
c("GO:0016358","dendrite development",0.600,4.936,0.788,2.033,-11.735,0.820,0.000),
c("GO:0030001","metal ion transport",3.006,-4.280,-1.055,2.730,-2.221,0.991,0.000),
c("GO:0097756"," ",0.466,-5.691,-2.916,1.924,-3.244,1.000,0.000),
c("GO:0006470","protein dephosphorylation",1.178,-5.358,0.424,2.324,-2.992,0.975,0.015),
c("GO:0007163"," ",1.105,-5.177,-4.485,2.297,-2.620,0.990,0.015),
c("GO:0030010","establishment of cell polarity",0.684,-4.876,-5.110,2.090,-2.641,0.990,0.015),
c("GO:0031589","cell-substrate adhesion",1.032,-5.767,-2.092,2.267,-2.660,0.988,0.015),
c("GO:0042110","T cell activation",1.329,-5.486,-3.818,2.377,-2.266,0.990,0.015),
c("GO:0050673"," ",0.494,-5.860,-1.250,1.949,-3.184,0.987,0.015),
c("GO:0070997","neuron death",0.325,-4.817,2.445,1.771,-3.073,0.984,0.015),
c("GO:0043087","regulation of GTPase activity",1.929,-1.764,2.713,2.538,-6.963,0.954,0.038),
c("GO:0022604","regulation of cell morphogenesis",1.705,1.653,-8.360,2.484,-6.995,0.929,0.044),
c("GO:0030278"," ",0.634,3.640,-8.398,2.057,-2.996,0.955,0.044),
c("GO:0007265","Ras protein signal transduction",0.965,-3.269,4.687,2.238,-5.042,0.930,0.050),
c("GO:0045785","positive regulation of cell adhesion",2.384,-3.633,-3.498,2.629,-4.003,0.943,0.050),
c("GO:0050678","regulation of epithelial cell proliferation",1.896,-4.846,-2.540,2.530,-2.549,0.961,0.050),
c("GO:0051056","small GTPase mediated signaling",1.817,0.265,5.237,2.512,-5.293,0.944,0.050),
c("GO:1901214"," ",1.705,-5.305,-3.480,2.484,-2.618,0.962,0.050),
c("GO:0009612","response to mechanical stimulus",1.189,2.412,4.712,2.328,-2.832,0.980,0.081),
c("GO:0097305","response to alcohol",1.380,2.701,6.088,2.393,-4.332,0.974,0.081),
c("GO:0001503","ossification",1.464,4.976,-8.171,2.418,-4.448,0.918,0.104),
c("GO:0007585","respiratory gaseous exchange by respiratory system",0.280,4.634,-8.224,1.708,-3.055,0.918,0.104),
c("GO:0042310","vasoconstriction",0.174,-1.829,-4.309,1.505,-3.809,0.865,0.104),
c("GO:0044706"," ",1.144,-0.639,-0.709,2.312,-2.832,0.916,0.104),
c("GO:0009896"," ",2.804,-2.705,0.098,2.700,-3.103,0.945,0.114),
c("GO:0034330","cell junction organization",2.765,4.447,6.103,2.694,-3.975,0.971,0.124),
c("GO:0050808","synapse organization",1.570,5.141,5.863,2.449,-4.361,0.957,0.124),
c("GO:0035249","synaptic transmission, glutamatergic",0.146,-4.193,3.527,1.431,-2.722,0.975,0.127),
c("GO:0060560","developmental growth in morphogenesis",0.623,7.618,1.612,2.049,-6.963,0.862,0.132),
c("GO:0070189","kynurenine metabolic process",0.062,-4.908,1.466,1.079,-2.195,0.981,0.134),
c("GO:0038127","ERBB signaling pathway",0.393,-2.371,5.517,1.851,-2.944,0.932,0.134),
c("GO:0007389","pattern specification process",2.350,2.645,-0.974,2.623,-2.040,0.884,0.140),
c("GO:0009791","post-embryonic development",0.449,3.318,-3.525,1.908,-2.228,0.884,0.140),
c("GO:0048736","appendage development",0.965,5.847,-5.957,2.238,-3.289,0.884,0.140),
c("GO:0009410","response to xenobiotic stimulus",0.695,3.173,6.765,2.097,-2.102,0.976,0.154),
c("GO:0046677","response to antibiotic",0.247,3.470,6.567,1.653,-3.289,0.976,0.154),
c("GO:0001655","urogenital system development",1.789,6.537,-5.296,2.505,-5.749,0.876,0.155),
c("GO:0048608","reproductive structure development",2.316,4.538,-4.135,2.617,-4.655,0.870,0.155),
c("GO:0048732","gland development",2.283,6.206,-4.216,2.611,-5.724,0.864,0.155),
c("GO:0048880","sensory system development",2.047,5.132,-4.986,2.563,-5.711,0.876,0.155),
c("GO:0060541","respiratory system development",1.110,6.180,-5.307,2.299,-4.969,0.876,0.155),
c("GO:0061458","reproductive system development",2.333,5.769,-5.268,2.620,-4.704,0.876,0.155),
c("GO:0072001","renal system development",1.604,5.486,-4.944,2.458,-5.191,0.872,0.155),
c("GO:0090287","regulation of cellular response to growth factor stimulus",1.621,0.623,6.627,2.462,-2.993,0.953,0.156),
c("GO:0042445","hormone metabolic process",1.105,-3.755,-5.951,2.297,-2.524,0.953,0.164),
c("GO:0050803","regulation of synapse structure or activity",1.223,-3.555,-6.103,2.340,-3.745,0.960,0.164),
c("GO:0055074","calcium ion homeostasis",2.378,-3.684,-5.699,2.628,-2.323,0.960,0.164),
c("GO:0006465","signal peptide processing",0.073,-5.649,0.113,1.146,-2.647,0.978,0.175),
c("GO:0048863","stem cell differentiation",0.864,3.866,2.222,2.190,-3.324,0.889,0.176),
c("GO:0051966","regulation of synaptic transmission, glutamatergic",0.376,-0.491,5.384,1.833,-3.750,0.944,0.179),
c("GO:0099177","regulation of trans-synaptic signaling",2.372,-0.620,6.018,2.627,-2.047,0.948,0.179),
c("GO:0001654","eye development",1.991,6.881,-4.037,2.551,-5.288,0.854,0.187),
c("GO:0003205","cardiac chamber development",0.892,7.454,-3.617,2.204,-5.058,0.850,0.187),
c("GO:0030324","lung development",0.959,7.672,-2.918,2.236,-5.620,0.854,0.187),
c("GO:0030879","mammary gland development",0.701,7.136,-4.171,2.100,-4.033,0.861,0.187),
c("GO:0031214","biomineral tissue development",0.505,6.860,-2.482,1.959,-4.214,0.850,0.187),
c("GO:0048568","embryonic organ development",2.400,8.057,-2.700,2.632,-4.003,0.855,0.187),
c("GO:0048569","post-embryonic animal organ development",0.084,6.544,-4.382,1.204,-2.449,0.864,0.187),
c("GO:0060348","bone development",1.032,6.158,-3.732,2.267,-2.669,0.861,0.187),
c("GO:0010469","regulation of signaling receptor activity",1.060,-0.581,4.438,2.279,-2.047,0.937,0.192),
c("GO:0030510","regulation of BMP signaling pathway",0.561,-0.026,6.183,2.004,-2.282,0.944,0.192),
c("GO:0042059","negative regulation of epidermal growth factor receptor signaling pathway",0.264,0.260,4.482,1.681,-2.026,0.940,0.192),
c("GO:0090092","regulation of transmembrane receptor protein serine/threonine kinase signaling pathway",1.397,0.350,5.948,2.398,-2.687,0.946,0.192),
c("GO:1901184","regulation of ERBB signaling pathway",0.522,-0.289,6.066,1.973,-2.137,0.946,0.192),
c("GO:2000310","regulation of NMDA receptor activity",0.219,-0.714,3.903,1.602,-2.719,0.933,0.192),
c("GO:0043279","response to alkaloid",0.645,2.920,6.466,2.064,-2.378,0.973,0.194),
c("GO:0048545","response to steroid hormone",1.587,2.526,6.676,2.453,-2.766,0.973,0.194),
c("GO:0018209","peptidyl-serine modification",1.155,-5.566,0.894,2.316,-2.754,0.975,0.195),
c("GO:0045778","positive regulation of ossification",0.275,0.207,-5.501,1.699,-2.095,0.937,0.208),
c("GO:0007215","glutamate receptor signaling pathway",0.264,-2.579,5.260,1.681,-2.179,0.935,0.214),
c("GO:0048638","regulation of developmental growth",1.755,0.599,-8.059,2.497,-3.961,0.925,0.217),
c("GO:0060998","regulation of dendritic spine development",0.331,2.211,-8.326,1.778,-4.456,0.935,0.217),
c("GO:0070167","regulation of biomineral tissue development",0.516,2.032,-7.975,1.968,-2.956,0.922,0.217),
c("GO:0032147","activation of protein kinase activity",2.008,-1.915,1.363,2.555,-6.234,0.927,0.217),
c("GO:0050807","regulation of synapse organization",1.161,-2.462,-6.731,2.318,-4.318,0.934,0.220),
c("GO:0030900","forebrain development",2.131,5.045,-2.285,2.581,-9.126,0.837,0.228),
c("GO:0035108","limb morphogenesis",0.780,8.197,0.755,2.146,-3.047,0.852,0.231),
c("GO:0042476","odontogenesis",0.651,7.873,-0.981,2.068,-2.096,0.839,0.231),
c("GO:0006939","smooth muscle contraction",0.275,-0.941,-3.191,1.699,-2.035,0.912,0.235),
c("GO:0007605","sensory perception of sound",0.847,-1.264,-3.022,2.182,-2.483,0.911,0.235),
c("GO:0006367","transcription initiation from RNA polymerase II promoter",0.852,-5.650,-0.169,2.185,-2.282,0.980,0.239),
c("GO:0046578","regulation of Ras protein signal transduction",1.110,0.029,5.404,2.299,-3.784,0.942,0.250),
c("GO:0090036","regulation of protein kinase C signaling",0.090,0.364,5.482,1.230,-2.190,0.944,0.250),
c("GO:0051222","positive regulation of protein transport",1.800,-2.715,-1.483,2.508,-2.196,0.948,0.253),
c("GO:0048762","mesenchymal cell differentiation",0.903,6.495,-1.391,2.210,-3.223,0.841,0.255),
c("GO:0060485","mesenchyme development",1.234,6.575,-2.541,2.344,-3.975,0.852,0.255),
c("GO:0007254","JNK cascade",0.466,-3.525,4.520,1.924,-2.047,0.931,0.258),
c("GO:0019932","second-messenger-mediated signaling",1.268,-3.552,4.239,2.356,-2.102,0.933,0.258),
c("GO:0031098","stress-activated protein kinase signaling cascade",0.623,-3.246,4.287,2.049,-2.883,0.933,0.258),
c("GO:1901215","negative regulation of neuron death",1.122,-4.255,-5.081,2.303,-2.116,0.956,0.260),
c("GO:0002064","epithelial cell development",1.116,6.480,1.885,2.301,-2.996,0.857,0.260),
c("GO:0010837","regulation of keratinocyte proliferation",0.196,-4.570,-2.549,1.556,-2.719,0.959,0.260),
c("GO:0045471","response to ethanol",0.774,2.659,6.276,2.143,-2.275,0.974,0.264),
c("GO:0042063","gliogenesis",1.211,4.441,-0.135,2.336,-2.336,0.843,0.280),
c("GO:0001764","neuron migration",0.645,4.253,-0.409,2.064,-6.995,0.837,0.290),
c("GO:0050769","positive regulation of neurogenesis",1.234,3.319,-4.156,2.344,-5.898,0.761,0.290),
c("GO:0060999","positive regulation of dendritic spine development",0.224,1.098,-7.538,1.613,-2.465,0.921,0.290),
c("GO:0030033","microvillus assembly",0.095,5.890,4.908,1.255,-3.708,0.950,0.297),
c("GO:0032528","microvillus organization",0.107,6.280,4.892,1.301,-2.241,0.951,0.297),
c("GO:0106027","neuron projection organization",0.230,6.129,4.866,1.623,-2.849,0.951,0.297),
c("GO:0060070","canonical Wnt signaling pathway",0.466,-3.783,3.765,1.924,-2.391,0.933,0.300),
c("GO:0060359","response to ammonium ion",0.034,3.220,6.299,0.845,-2.143,0.975,0.304),
c("GO:0051402","neuron apoptotic process",0.275,-5.017,2.465,1.699,-2.195,0.983,0.305),
c("GO:0007565","female pregnancy",0.993,-0.263,-1.322,2.250,-2.502,0.911,0.305),
c("GO:0043547","positive regulation of GTPase activity",1.430,-1.446,2.515,2.408,-5.749,0.951,0.306),
c("GO:0042176","regulation of protein catabolic process",2.126,-2.872,1.178,2.580,-3.097,0.952,0.309),
c("GO:0045732","positive regulation of protein catabolic process",1.268,-2.366,0.574,2.356,-2.832,0.939,0.309),
c("GO:0021510","spinal cord development",0.555,5.305,-2.325,2.000,-2.558,0.839,0.315),
c("GO:0021953","central nervous system neuron differentiation",1.015,4.540,-0.552,2.260,-6.137,0.832,0.315),
c("GO:0050954","sensory perception of mechanical stimulus",0.965,-1.116,-2.883,2.238,-2.454,0.911,0.316),
c("GO:0046660","female sex differentiation",0.595,2.946,-2.718,2.029,-2.445,0.879,0.316),
c("GO:0010769","regulation of cell morphogenesis involved in differentiation",0.522,1.453,-8.353,1.973,-6.137,0.926,0.319),
c("GO:2000027","regulation of animal organ morphogenesis",1.004,1.792,-8.341,2.255,-3.592,0.929,0.319),
c("GO:0044331","cell-cell adhesion mediated by cadherin",0.045,-5.765,-2.235,0.954,-2.095,0.988,0.320),
c("GO:0048645","animal organ formation",0.208,7.616,-0.813,1.580,-2.095,0.835,0.320),
c("GO:0051047","positive regulation of secretion",1.739,-2.627,-1.264,2.493,-2.048,0.949,0.321),
c("GO:0070231","T cell apoptotic process",0.084,-4.939,2.579,1.204,-2.116,0.980,0.324),
c("GO:0018108","peptidyl-tyrosine phosphorylation",0.864,-5.283,0.872,2.190,-2.467,0.973,0.327),
c("GO:0018212","peptidyl-tyrosine modification",0.881,-5.432,1.069,2.199,-2.520,0.975,0.327),
c("GO:0060840","artery development",0.499,7.852,-4.043,1.954,-2.179,0.863,0.329),
c("GO:0006816","calcium ion transport",1.346,-4.484,-1.316,2.382,-2.121,0.991,0.329),
c("GO:0098662","inorganic cation transmembrane transport",3.477,-4.486,-1.123,2.793,-2.185,0.982,0.329),
c("GO:0021915","neural tube development",0.847,6.179,-0.410,2.182,-2.520,0.831,0.332),
c("GO:0030323","respiratory tube development",0.981,7.868,-2.880,2.246,-5.587,0.854,0.332),
c("GO:0035148","tube formation",0.808,8.307,-0.024,2.161,-3.961,0.852,0.332),
c("GO:0021954","central nervous system neuron development",0.499,4.776,-0.254,1.954,-3.963,0.826,0.334),
c("GO:0045666","positive regulation of neuron differentiation",0.499,0.945,-7.284,1.954,-5.711,0.915,0.334),
c("GO:0061097","regulation of protein tyrosine kinase activity",0.527,-1.912,2.096,1.978,-2.533,0.941,0.339),
c("GO:0021537","telencephalon development",1.408,4.894,-2.020,2.401,-6.180,0.831,0.345),
c("GO:0007178","transmembrane receptor protein serine/threonine kinase signaling pathway",1.071,-2.330,5.391,2.283,-2.068,0.932,0.349),
c("GO:0030509","BMP signaling pathway",0.432,1.584,6.239,1.892,-2.228,0.919,0.349),
c("GO:0007162","negative regulation of cell adhesion",1.576,-3.980,-4.244,2.450,-2.201,0.951,0.349),
c("GO:0010810","regulation of cell-substrate adhesion",1.183,-4.507,-3.987,2.326,-2.996,0.957,0.349),
c("GO:0022407","regulation of cell-cell adhesion",2.440,-4.436,-3.846,2.639,-2.724,0.957,0.349),
c("GO:0018105","peptidyl-serine phosphorylation",1.021,-5.417,0.749,2.262,-2.312,0.973,0.353),
c("GO:0046777","protein autophosphorylation",1.026,-5.077,0.724,2.265,-2.190,0.975,0.353),
c("GO:0002065","columnar/cuboidal epithelial cell differentiation",0.421,6.911,2.117,1.881,-2.669,0.865,0.355),
c("GO:0002066","columnar/cuboidal epithelial cell development",0.196,6.377,1.912,1.556,-2.486,0.855,0.355),
c("GO:0048813","dendrite morphogenesis",0.337,6.000,0.612,1.785,-6.775,0.801,0.356),
c("GO:0031345","negative regulation of cell projection organization",1.021,-1.689,-7.216,2.262,-2.096,0.931,0.359),
c("GO:0031346","positive regulation of cell projection organization",1.924,-1.739,-6.749,2.537,-6.105,0.923,0.359),
c("GO:0060562","epithelial tube morphogenesis",1.688,7.643,0.366,2.480,-3.784,0.838,0.361),
c("GO:0001558","regulation of cell growth",2.288,-1.748,-7.439,2.612,-3.226,0.936,0.361),
c("GO:0045927","positive regulation of growth",1.391,-2.038,-5.505,2.396,-2.862,0.942,0.361),
c("GO:0048639","positive regulation of developmental growth",0.920,0.497,-7.314,2.217,-2.722,0.912,0.361),
c("GO:0050773","regulation of dendrite development",0.561,-0.333,-7.628,2.004,-8.444,0.910,0.362),
c("GO:1904951","positive regulation of establishment of protein localization",1.879,-2.780,-1.711,2.526,-2.004,0.949,0.376),
c("GO:0043583","ear development",1.172,6.703,-3.772,2.322,-2.565,0.857,0.380),
c("GO:0090596","sensory organ morphogenesis",1.397,7.721,-1.325,2.398,-4.873,0.834,0.380),
c("GO:0000186","activation of MAPKK activity",0.320,-1.705,1.398,1.763,-2.972,0.927,0.382),
c("GO:0071902","positive regulation of protein serine/threonine kinase activity",1.772,-1.799,1.310,2.501,-5.059,0.927,0.382),
c("GO:0003007","heart morphogenesis",1.340,7.893,-1.640,2.380,-3.953,0.829,0.382),
c("GO:0003151","outflow tract morphogenesis",0.381,7.778,-1.711,1.839,-3.435,0.827,0.382),
c("GO:0003279","cardiac septum development",0.566,7.576,-3.504,2.009,-5.042,0.846,0.382),
c("GO:0071772","response to BMP",0.522,2.380,6.568,1.973,-2.185,0.971,0.383),
c("GO:0007173","epidermal growth factor receptor signaling pathway",0.280,-2.262,5.565,1.708,-2.702,0.932,0.385),
c("GO:0035150","regulation of tube size",0.735,-3.156,-5.375,2.121,-2.298,0.951,0.386),
c("GO:0061387","regulation of extent of cell growth",0.617,-1.601,-5.790,2.045,-2.035,0.894,0.386),
c("GO:0031331","positive regulation of cellular catabolic process",2.462,-2.380,0.017,2.643,-2.095,0.941,0.388),
c("GO:0034329","cell junction assembly",1.537,5.460,5.770,2.439,-4.037,0.956,0.390),
c("GO:0034332","adherens junction organization",0.342,5.416,5.899,1.792,-3.220,0.956,0.390),
c("GO:0045216","cell-cell junction organization",1.038,5.269,5.918,2.270,-2.095,0.957,0.390),
c("GO:0099173","postsynapse organization",0.482,5.248,5.802,1.940,-3.953,0.956,0.390),
c("GO:0010721","negative regulation of cell development",0.987,1.162,-8.097,2.248,-4.318,0.922,0.390),
c("GO:0043405","regulation of MAP kinase activity",1.755,-2.077,2.141,2.497,-4.018,0.940,0.390),
c("GO:0043406","positive regulation of MAP kinase activity",1.307,-0.934,3.033,2.369,-4.714,0.910,0.390),
c("GO:0097485","neuron projection guidance",1.514,5.565,1.086,2.433,-4.484,0.785,0.391),
c("GO:0043616","keratinocyte proliferation",0.062,-5.834,-1.354,1.079,-2.189,0.987,0.393),
c("GO:0003018","vascular process in circulatory system",1.397,-1.170,-3.474,2.398,-3.170,0.908,0.394),
c("GO:0048705","skeletal system morphogenesis",1.211,7.873,-1.148,2.336,-2.195,0.837,0.395),
c("GO:0060349","bone morphogenesis",0.522,7.672,-1.056,1.973,-2.242,0.837,0.395),
c("GO:0007409","axonogenesis",2.103,6.132,0.632,2.575,-5.784,0.803,0.402),
c("GO:0010976","positive regulation of neuron projection development",0.858,-1.621,-6.790,2.188,-5.724,0.921,0.403),
c("GO:0010977","negative regulation of neuron projection development",0.768,-1.557,-7.285,2.140,-2.344,0.928,0.403),
c("GO:0050770","regulation of axonogenesis",0.892,-0.128,-7.734,2.204,-2.135,0.905,0.403),
c("GO:0051961","negative regulation of nervous system development",0.813,1.619,-7.827,2.164,-3.733,0.921,0.403),
c("GO:0001738","morphogenesis of a polarized epithelium",0.280,7.690,1.033,1.708,-2.047,0.854,0.404),
c("GO:0001838","embryonic epithelial tube formation",0.679,7.808,0.069,2.086,-2.883,0.830,0.404),
c("GO:0016331","morphogenesis of embryonic epithelium",0.796,7.592,0.493,2.155,-2.662,0.838,0.404),
c("GO:0050804","modulation of chemical synaptic transmission",2.367,-0.554,5.537,2.626,-2.074,0.944,0.406),
c("GO:0050806","positive regulation of synaptic transmission",0.746,-0.120,4.065,2.127,-2.095,0.931,0.406),
c("GO:0001963","synaptic transmission, dopaminergic",0.084,-4.115,3.442,1.204,-2.096,0.975,0.407),
c("GO:0001890","placenta development",0.808,5.099,-3.680,2.161,-3.308,0.858,0.408),
c("GO:0001892","embryonic placenta development",0.466,5.664,-3.229,1.924,-2.628,0.848,0.409),
c("GO:0007411","axon guidance",1.509,5.662,1.122,2.431,-4.553,0.784,0.409),
c("GO:0061180","mammary gland epithelium development",0.320,6.828,-1.965,1.763,-2.708,0.844,0.410),
c("GO:0021536","diencephalon development",0.432,5.095,-2.044,1.892,-3.101,0.831,0.418),
c("GO:0021761","limbic system development",0.600,5.285,-1.940,2.033,-2.903,0.831,0.418),
c("GO:0021872","forebrain generation of neurons",0.348,5.148,-1.150,1.799,-2.266,0.817,0.418),
c("GO:0021885","forebrain cell migration",0.348,4.801,-1.464,1.799,-4.379,0.821,0.418),
c("GO:0021987","cerebral cortex development",0.639,5.221,-1.732,2.061,-4.250,0.829,0.418),
c("GO:0150063","visual system development",2.013,6.958,-4.941,2.556,-5.547,0.868,0.422),
c("GO:0043010","camera-type eye development",1.733,6.784,-3.984,2.491,-4.403,0.854,0.424),
c("GO:0048592","eye morphogenesis",0.824,7.522,-1.478,2.170,-4.155,0.831,0.425),
c("GO:0050768","negative regulation of neurogenesis",0.785,3.504,-4.393,2.149,-3.722,0.768,0.425),
c("GO:0016049","cell growth",0.494,3.688,4.895,1.949,-4.890,0.971,0.427),
c("GO:0048588","developmental cell growth",0.482,5.250,2.214,1.940,-5.052,0.861,0.428),
c("GO:0090630","activation of GTPase activity",0.645,-1.300,2.429,2.064,-2.124,0.951,0.429),
c("GO:1900006","positive regulation of dendrite development",0.095,-0.267,-7.179,1.255,-4.929,0.896,0.429),
c("GO:0050679","positive regulation of epithelial cell proliferation",1.054,-3.581,-2.520,2.276,-2.035,0.945,0.431),
c("GO:0035023","regulation of Rho protein signal transduction",0.482,0.050,5.553,1.940,-2.818,0.942,0.435),
c("GO:0001822","kidney development",1.554,5.784,-4.187,2.444,-4.685,0.860,0.437),
c("GO:0035335","peptidyl-tyrosine dephosphorylation",0.583,-5.198,0.424,2.021,-2.290,0.975,0.439),
c("GO:0000187","activation of MAPK activity",0.869,-0.964,2.954,2.193,-2.095,0.910,0.439),
c("GO:1903859","regulation of dendrite extension",0.151,0.102,-7.697,1.447,-2.095,0.905,0.442),
c("GO:0010770","positive regulation of cell morphogenesis involved in differentiation",0.432,0.874,-7.555,1.892,-3.780,0.905,0.446),
c("GO:0040036","regulation of fibroblast growth factor receptor signaling pathway",0.163,0.070,6.150,1.477,-2.254,0.944,0.448),
c("GO:0072006","nephron development",0.695,5.690,-4.111,2.097,-2.190,0.860,0.449),
c("GO:0097061","dendritic spine organization",0.174,5.561,5.117,1.505,-2.619,0.936,0.451),
c("GO:0007266","Rho protein signal transduction",0.337,-3.155,4.584,1.785,-2.996,0.929,0.460),
c("GO:0021543","pallium development",0.948,5.087,-1.673,2.230,-3.536,0.829,0.463),
c("GO:0021544","subpallium development",0.129,5.100,-1.846,1.380,-2.804,0.829,0.463),
c("GO:0021756","striatum development",0.095,4.930,-1.848,1.255,-2.996,0.829,0.463),
c("GO:0022029","telencephalon cell migration",0.331,4.781,-1.591,1.778,-3.942,0.818,0.463),
c("GO:0048593","camera-type eye morphogenesis",0.679,7.410,-1.502,2.086,-2.133,0.831,0.464),
c("GO:0003197","endocardial cushion development",0.247,7.464,-2.493,1.653,-2.095,0.836,0.477),
c("GO:0099175","regulation of postsynapse organization",0.488,-2.468,-6.667,1.944,-3.975,0.934,0.478),
c("GO:0061001","regulation of dendritic spine morphogenesis",0.252,-0.584,-7.297,1.663,-2.095,0.894,0.484),
c("GO:0045665","negative regulation of neuron differentiation",0.387,1.274,-8.042,1.845,-3.614,0.922,0.493),
c("GO:0007043","cell-cell junction assembly",0.701,5.564,5.808,2.100,-2.342,0.955,0.496),
c("GO:0021879","forebrain neuron differentiation",0.286,5.159,-0.999,1.716,-2.190,0.813,0.498),
c("GO:0021952","central nervous system projection neuron axonogenesis",0.146,5.814,0.352,1.431,-2.095,0.793,0.498),
c("GO:0032486","Rap protein signal transduction",0.062,-3.161,4.697,1.079,-2.449,0.929,0.504),
c("GO:0035107","appendage morphogenesis",0.780,8.131,0.843,2.146,-3.047,0.853,0.504),
c("GO:0060173","limb development",0.965,8.299,1.766,2.238,-3.289,0.874,0.504),
c("GO:0003206","cardiac chamber morphogenesis",0.667,7.814,-1.843,2.079,-4.003,0.824,0.512),
c("GO:0003231","cardiac ventricle development",0.679,7.637,-3.441,2.086,-3.953,0.846,0.512),
c("GO:0060411","cardiac septum morphogenesis",0.370,7.734,-1.900,1.826,-5.058,0.823,0.512),
c("GO:0072175","epithelial tube formation",0.723,7.711,0.225,2.114,-2.845,0.835,0.523),
c("GO:0030326","embryonic limb morphogenesis",0.656,8.167,0.430,2.072,-2.061,0.844,0.527),
c("GO:0035113","embryonic appendage morphogenesis",0.656,8.112,0.509,2.072,-2.061,0.844,0.527),
c("GO:0035296","regulation of tube diameter",0.729,-3.047,-5.218,2.117,-2.360,0.948,0.533),
c("GO:0019229","regulation of vasoconstriction",0.353,-0.923,-4.725,1.806,-2.371,0.852,0.534),
c("GO:0097746","blood vessel diameter maintenance",0.729,-1.753,-4.281,2.117,-2.360,0.865,0.534),
c("GO:0014020","primary neural tube formation",0.533,6.848,-0.415,1.982,-2.124,0.814,0.535),
c("GO:0060443","mammary gland morphogenesis",0.236,7.427,-1.154,1.633,-2.629,0.835,0.539),
c("GO:0001841","neural tube formation",0.578,6.898,-0.377,2.017,-2.344,0.814,0.542),
c("GO:0051403","stress-activated MAPK cascade",0.595,-3.544,4.441,2.029,-2.169,0.931,0.551),
c("GO:0060996","dendritic spine development",0.146,5.035,0.865,1.431,-5.225,0.817,0.555),
c("GO:0003281","ventricular septum development",0.387,7.499,-3.442,1.845,-4.332,0.845,0.562),
c("GO:0060412","ventricular septum morphogenesis",0.213,7.668,-1.855,1.591,-3.942,0.823,0.562),
c("GO:0048814","regulation of dendrite morphogenesis",0.365,-0.150,-7.648,1.820,-3.986,0.904,0.563),
c("GO:0030501","positive regulation of bone mineralization",0.224,1.324,-7.364,1.613,-2.722,0.907,0.570),
c("GO:0010771","negative regulation of cell morphogenesis involved in differentiation",0.073,1.035,-8.050,1.146,-2.694,0.912,0.571),
c("GO:0071773","cellular response to BMP stimulus",0.522,2.208,6.455,1.973,-2.185,0.960,0.571),
c("GO:0030500","regulation of bone mineralization",0.426,1.945,-7.889,1.886,-2.323,0.919,0.572),
c("GO:0030282","bone mineralization",0.275,6.846,-2.583,1.699,-3.784,0.850,0.574),
c("GO:1990138","neuron projection extension",0.342,5.973,0.828,1.792,-5.042,0.793,0.577),
c("GO:0048675","axon extension",0.191,6.040,0.852,1.544,-3.442,0.792,0.579),
c("GO:0060563","neuroepithelial cell differentiation",0.101,6.998,2.069,1.279,-2.190,0.863,0.594),
c("GO:0021795","cerebral cortex cell migration",0.236,4.736,-1.659,1.633,-3.046,0.818,0.615),
c("GO:0048846","axon extension involved in axon guidance",0.045,5.655,1.299,0.954,-2.133,0.773,0.616),
c("GO:1902284","neuron projection extension involved in neuron projection guidance",0.045,5.600,1.298,0.954,-2.133,0.774,0.616),
c("GO:0070169","positive regulation of biomineral tissue development",0.258,1.417,-7.450,1.672,-2.918,0.909,0.645),
c("GO:0060997","dendritic spine morphogenesis",0.101,6.043,1.231,1.279,-2.371,0.787,0.660));

one.data <- data.frame(revigo.data);
names(one.data) <- revigo.names;
one.data <- one.data [(one.data$plot_X != "null" & one.data$plot_Y != "null"), ];
one.data$plot_X <- as.numeric( as.character(one.data$plot_X) );
one.data$plot_Y <- as.numeric( as.character(one.data$plot_Y) );

one.data$plot_size <- as.numeric( as.character(one.data$plot_size) );
one.data$value <- as.numeric( as.character(one.data$value) );
one.data$frequency <- as.numeric( as.character(one.data$frequency) );
one.data$uniqueness <- as.numeric( as.character(one.data$uniqueness) );
one.data$dispensability <- as.numeric( as.character(one.data$dispensability) );
#head(one.data);


# --------------------------------------------------------------------------
# Names of the axes, sizes of the numbers and letters, names of the columns,
# etc. can be changed below

p1 <- ggplot( data = one.data );
p1 <- p1 + geom_point( aes( plot_X, plot_Y, colour = value)) + scale_size_area();
p1 <- p1 + scale_colour_gradientn( colours = c("blue", "green", "yellow", "red"), limits = c( min(one.data$value), 0) );
#p1 <- p1 + geom_point( aes(plot_X, plot_Y, size = plot_size), shape = 21, fill = "transparent", colour = I (alpha ("black", 0.6) )) + scale_size_area();
p1 <- p1 + scale_size( range=c(5, 30)) + theme_bw(); # + scale_fill_gradientn(colours = heat_hcl(7), limits = c(-300, 0) );
ex <- one.data [ one.data$dispensability < 0.15, ];
p1 <- p1 + geom_text_repel( data = ex, aes(plot_X, plot_Y, label = description), colour = I(alpha("black", 0.85)), size = 3 );
p1 <- p1 + labs (y = "semantic space x", x = "semantic space y");
p1 <- p1 + theme(legend.key = element_blank()) ;
one.x_range = max(one.data$plot_X) - min(one.data$plot_X);
one.y_range = max(one.data$plot_Y) - min(one.data$plot_Y);
p1 <- p1 + xlim(min(one.data$plot_X)-one.x_range/10,max(one.data$plot_X)+one.x_range/10);
p1 <- p1 + ylim(min(one.data$plot_Y)-one.y_range/10,max(one.data$plot_Y)+one.y_range/10);


# --------------------------------------------------------------------------
# Output the plot to screen

p1;

# Uncomment the line below to also save the plot to a file.
# The file type depends on the extension (default=pdf).

# ggsave("/path_to_your_file/revigo-plot.pdf");

