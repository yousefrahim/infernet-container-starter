# infernet-container-starter

Welcome to this repository! 🎉 This repo contains a series of examples that demonstrate
the true power of infernet, and the wide range of applications that can be built using
it:

## Examples
1. [Hello World](projects/hello-world/hello-world.md): Infernet's version of a `hello-world` program. Here, we deploy
a container that simply echoes back the input to us.
2. [Running a Torch Model on Infernet](projects/torch-iris/torch-iris.md): This example shows you how to deploy a pre-trained [pytorch](https://pytorch.org/)
model to infernet. Using this example will make it easier for you to deploy your own models to infernet.
3. [Running an ONNX Model on Infernet](projects/onnx-iris/onnx-iris.md): Same as the previous example, but this time we deploy
 an ONNX model to infernet.
4. [Prompt to NFT](projects/prompt-to-nft/prompt-to-nft.md): In this example, we use [stablediffusion](https://github.com/Stability-AI/stablediffusion) to
 mint NFTs on-chain using a prompt.
5. [TGI Inference with Mistral-7b](projects/tgi-llm/tgi-llm.md): This example shows you how to deploy an arbitrary
LLM model using [Huggingface's TGI](https://huggingface.co/docs/text-generation-inference/en/index), and use it with an Infernet Node.
6. [Running OpenAI's GPT-4 on Infernet](projects/gpt4/gpt4.md): This example shows you how to deploy OpenAI's GPT-4 model
to infernet.



______________________________________________________________________________________________________________________

git clone 
```
https://github.com/0xHawre/infernet-container-starter.git && cd Owner avatar
infernet-container-starter
```
install hte requirement 
``` chmod +x requirement.sh && /.requirement
```















// the firs session running to creat the config files


//config 3 file 
//nano ~/infernet-container-starter/deploy/config.json
//nano ~/infernet-container-starter/projects/hello-world/container/config.json
//nano ~/infernet-container-starter/projects/hello-world/contracts/Makefile pv key 
{
    suff that have to be change {
        RPC URL: https://mainnet.base.org/
        Private Key: Enter your private key (throwaway wallet). Add “0x” to your key if it does not start with 0x.
        rig address=. 0x3B1554f346DFe5c482Bb4BA31b880c1C18412170
            "snapshot_sync": {
        "sleep": 3,
        "starting_sub_id": 160000,
        "batch_size": 800,
        "sync_period": 30
    },
    delet the docker settein in the script 
    cahnge the "trail_head_blocks": 3

    }

}

// edit nano ~/infernet-container-starter/deploy/docker-compose.yaml node version 