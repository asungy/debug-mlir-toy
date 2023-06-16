# debug-mlir-toy

Building and debugging [MLIR examples][mlir_examples] for educational purposes.

## Docker

To start containers run:
```bash
docker compose up -d
```

To attach to the dev container:
```bash
docker exec -it debug-mlir-toy-dev-1 /bin/bash
```

To stop containers:
```bash
docker compose down
```

## LSP/compile_commands.json Issue

The `compile_commands.json` file is used to help LSP servers understand
compiler and source file information. Because this file is created in a
containerized environment, it may not work for your LSP server that runs
locally on your server. To resolve this, run this hacky script:
```bash
./scripts/fix_compile_commands
```

[mlir_examples]: https://github.com/llvm/llvm-project/tree/main/mlir/examples/toy
