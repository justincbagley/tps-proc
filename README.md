INTRODUCTION
-------

seqcap_pop is a series of commands and scripts we have been using for processing sequence capture data from population-level samples using tools within the [Phyluce](http://phyluce.readthedocs.org/en/latest/index.html#) package (Faircloth 2015). This pipeline includes some additional scripts not available from Phyluce and its dependencies (in the "bin" folder). Also, it requires GATK v3 or above, which may not be included in the current Phyluce release.

LICENSE
-------

The code within this repository is available under a 3-clause BSD license. See the License.txt file for more information.

CITATION
--------

If you use this pipeline for your own research, please cite Phyluce following the instructions [here](http://phyluce.readthedocs.org/en/latest/citing.html) and cite:

* Harvey MG, Smith BT, Glenn TC, Faircloth BC, Brumfield RT. In press. **Sequence capture versus restriction site associated DNA sequencing for shallow systematics**. *Systematic Biology* doi:10.1093/sysbio/syw036. 
    
You can also provide a link to this repository if desired:

    https://github.com/mgharvey/seqcap_pop

USAGE
--------

Install Phyluce and dependencies following the instructions [here](http://phyluce.readthedocs.org/en/latest/index.html). The custom Python scripts required for this pipeline are in the "bin" folder, so also download those and put them in your project folder. Make sure you have plenty of available hard drive space (depending on read counts, you may need upwards of 2GB for each sample). You will probably want to organize the output of each step below into a series of folders. Within my project folder, I typically set up a series of output folders labeled with consecutive numbers followed by a brief text descriptor:

- 1_raw-reads
- 2_clean-reads
- 3_velvet-output
- 4_match-contigs-to-probes
- 5_mapping
- 6_picard
- 7_merge-bams
- 8_GATK
- 9_SNP-tables
- 10_sequences
- 11_fasta-parts
- 12_raw-alignments
- 13_processed-phylip

You can make all of these folder now.

### 1.	Clean raw reads (Illumiprocessor)

Follow the instructions in the [Illumiprocessor documentation](http://illumiprocessor.readthedocs.org/en/latest/index.html) to make a configuration (.conf) file. Then execute Illumiprocessor. The command will look something like this:

```
illumiprocessor --input /path/to/1_raw-reads --output /path/to/2_clean-reads \
	--config illumiprocessor.conf --cores 8
```



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

