# ce_assignment_deeplearning

## My First Neuronal Network

A complete development environment to test your understanding about Neuronal Networks based on Docker and Jupyter Lab

You will be practice by implementing a  Dog-Size Classifier!

## Project Structure

```
ce_assigment_deeplearning/
├── Dockerfile
├── Makefile
├── README.md
├── requirements.txt
├── notebooks/
│   └── my_first_neuronal_network.ipynb
└── .gitignore
```

## Quick Start

Clone the repository
```bash
git clone <repo_uri>
cd ce_assigment_deeplearning
```

Build and run with make
```bash
make build
make run
```

If you want to execute one single command, use
```bash
make up
```

### Available Make Commands

- `make build` - Build the Docker image
- `make run` - Start Jupyter Lab server
- `make up` - Build Docker image and run it
- `make clean` - Clean up containers
- `make clean-all` - Clean up containers
- `make help` - Show all available commands

## Access Jupyter Lab

Once running, access Jupyter Lab at: `http://localhost:8888`


## Development Workflow

1. **Start the environment**: `make up`
2. **Open Jupyter Lab** in your browser
3. **Edit notebooks** in the `notebooks/` directory

## Project Components


### Notebook
- Location: `notebooks/my_first_neuronal_network.ipynb`
- Exercise to test your understanding of neuronal networks
- Includes unit tests


## Requirements

- Docker
- Make

## Environment Details

- **Python**: 3.11
- **Jupyter Lab**: Latest
- **Key Libraries**: pandas, pytest
- **Port**: 8888 (Jupyter Lab)
- **Volume Mount**: Current directory mounted to `/workspace`

## Customization

### Adding New Dependencies
1. Add packages to `requirements.txt`
2. Rebuild with `make build`

### Adding New Notebooks
- Place `.ipynb` files in the `notebooks/` directory
- They'll be automatically available in Jupyter Lab
