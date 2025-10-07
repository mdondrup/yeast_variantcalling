### Setup directories and install dependencies

rule setup: 
    input: "tools/NASP/nasptool/nasptool_linux_64"
    output: ".setup_done"
    shell:
    	"""
    	mkdir -p Fastqs fastp aligned vcf spades tools logs nasp nasp_output
		touch .setup_done
		"""	

rule install_nasp:
    conda: "../envs/nasp.yaml"
    output: "tools/NASP/nasptool/nasptool_linux_64"
    params:
        version="v1.2.1-p1md"
    message:
        "Installing NASP version {params.version}"
    shell:
        """
        mkdir -p tools
        cd tools
        rm -rf NASP
        git clone --branch v{params.version} https://github.com/mdondrup/NASP.git  
        cd NASP/nasp/nasptool
        go build -o ../nasptool_linux_64
        """ 
          