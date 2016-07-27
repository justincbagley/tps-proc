INTRODUCTION
-------

THIS SCRIPT allows users interested in conducting geometric morphometric analyses of 2D landmark data in the MorphoJ software (http://www.flywings.org.uk/MorphoJ_page.htm) to parse multiple .TPS files and extract and organize classifier variables for all 
images in each file into classifier files readable by MorphoJ. 

All landmarked images referred to in the input .TPS files are assumed to be in JPEG format, with ".jpg" file extensions. Suitable .TPS files should also contain images whose names end with the following three pieces of information in sequence, separated by underscores: 1) a four-letter site code for the locality from which each individual was collected (only lowercase or uppercase letters; no digits), 2) a two-letter area, state, or country code (e.g. drainage basin code, or other two-letter code), and 3) a three-character species code made up of letters or numbers (e.g. "sp2", "ANCI"). Each image filename should be of the general form "[any_code]_1_2_3.jpg"; for example, "JCB_11_B1501_TAQU_AP_sp2.jpg" would be a suitable filename.

IMPORTANT NOTE: Preferably, any information present in the filename prior to the four-letter site code should contain only letter or number characters without underscores. However, if you want to include underscores in this region of the filenames, then the text codes present MUST be greater than or less than, NOT equal to, four characters in length.

The script outputs a single file named "[input_file_root].classifiers.txt" for each .TPS file in the current working directory from which the script is executed. Each "classifiers" output file contains the classifiers (metadata) extracted for each image (i.e. individual) in tab-delimited format, and contains the following five columns: 1) "ID", a column of line numbers matching default MorphoJ identifiers, 2) "Code", or whatever text was present in the filenames represented by "[any_code" in the filename example above, 3) "Site", 4) "Area", and 5) "Species". Columns 3-5 match the required data present at the end of each image filename. Output files can be read by MorphoJ (or R) and used to define or color groups of individuals in the TPS files duringstatistical analyses or graphical visualization of results.

To load the classifiers in MorphoJ, open the .TPS file of interest in MorphoJ; select the data in the Project Tree pane; click on File > Import Classifier Variables...; navigate to the working directory and select the corresponding "classifiers" output file; use the default setting of Match by "identifier"; and click Open.

LICENSE
-------

The code within this repository is available under a GNU license. See the License.txt file for more information.

