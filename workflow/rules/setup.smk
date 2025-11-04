### Setup directories and install dependencies

rule setup: 
    input: "tools/NASP/nasp/nasptool_linux_64"
    output: ".setup_done"
    shell:
    	"""
    	mkdir -p Fastqs fastp aligned vcf spades tools logs nasp nasp_output
		touch .setup_done
		"""	

rule install_nasp:
    conda: "../envs/nasp.yaml"
    output: ["tools/NASP/nasp/nasptool_linux_64", directory("tools/NASP/nasp")]
    params:
        version="v1.2.1-p1md"
    log: "install_nasp.log"
    message:
        "Installing NASP version {params.version}"
    shell:
        """
        mkdir -p tools
        cd tools
        rm -rf NASP
        git clone --branch {params.version} https://github.com/mdondrup/NASP.git  > {log} 2>&1
        pip install -e NASP/
        cd ./NASP/nasp/nasptool
        go build -o ../nasptool_linux_64 >> {log} 2>&1
        cd ../../../..
        """ 
          