
### Step 1: Clone the Repository and Navigate In

```bash
git clone https://github.com/0xHawre/infernet-container-starter.git
cd infernet-container-starter
```

---

### Step 2: Run the Setup Scripts

#### 2.1 Make and Run `setup.sh`

```bash
chmod +x setup.sh
./setup.sh
```

#### 2.2 Make and Run `pvkey.sh`

```bash
chmod +x pvkey.sh
./pvkey.sh
```

#### 2.3 Make and Run `deploy.sh`

```bash
chmod +x deploy.sh
./deploy.sh
```

---

### Step 3: Deploy Contracts for the Hello World Project

```bash
project=hello-world make deploy-contracts
```

---
## Congratulations! 

### Call Contract
```bash 
nano ~/infernet-container-starter/projects/hello-world/contracts/script/CallContract.s.sol
```
Edit your CallContract.s.sol file by inserting the new contract address. The preconfigured address is SaysGM saysGm = SaysGM(youre contract address), change it to the address that was generated when calling SaysGM

Switch back to your second terminal session and initiate a new request for the Infernet Node:
```bash 
project=hello-world make call-contract
```

check base scan: https://basescan.org/



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


