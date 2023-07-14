#!/bin/bash

# Ensure we have /workspace in all scenarios
mkdir -p /workspace

if [[ ! -d /workspace/text-generation-webui ]]; then
	# If we don't already have /workspace/text-generation-webui, move it there
	mv /root/text-generation-webui /workspace
	mv /workspace/text-generation-webui/models /workspace/models
	ln -s /workspace/models /workspace/text-generation-webui/models
	pip3 install git+https://github.com/sterlind/GPTQ-for-LLaMa.git@lora_4bit
	git clone https://github.com/johnsmith0031/alpaca_lora_4bit /root/text-generation-webui/repositories

else
	# otherwise delete the default text-generation-webui folder which is always re-created on pod start from the Docker
	rm -rf /root/text-generation-webui
fi

# Then link /root/text-generation-webui folder to /workspace so it's available in that familiar location as well
ln -s /workspace/text-generation-webui /root/text-generation-webui
