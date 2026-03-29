#!/usr/bin/env bash
set -euo pipefail

# --- Config: change these if you want different names ---
VENV_DIR=".bits-drl-ass1"
KERNEL_NAME=".bits-drl-ass1"
KERNEL_DISPLAY="Python(.bits-drl-ass1)"
REQ_FILE="requirements.txt"

# --- Checks ---
command -v python3 >/dev/null 2>&1 || { echo "ERROR: python3 not found in PATH."; exit 2; }
command -v pip >/dev/null 2>&1 || { echo "ERROR: pip not found in PATH."; exit 2; }

echo "1) Creating virtual environment: ${VENV_DIR}"
if [ -d "${VENV_DIR}" ]; then
  echo " - Warning: ${VENV_DIR} already exists. Skipping creation."
else
  python3 -m venv "${VENV_DIR}"
  echo " - virtualenv created."
fi

# Activate the venv for the remainder of this script
# Note: running this script normally activates venv only inside the script.
# If you want your interactive shell to stay activated afterwards, run: `source setup_bits_dnn_ass1.sh`
echo "2) Activating virtual environment..."
# shellcheck source=/dev/null
source "${VENV_DIR}/bin/activate"

echo "Python executable: $(command -v python)"
echo "pip executable: $(command -v pip)"

echo "3) Upgrading pip and installing requirements from ${REQ_FILE} (if present)..."
python -m pip install --upgrade pip setuptools wheel
if [ -f "${REQ_FILE}" ]; then
  pip install -r "${REQ_FILE}"
else
  echo " - ${REQ_FILE} not found. Skipping pip install -r ${REQ_FILE}."
fi

# Ensure ipykernel is installed so we can register a kernel
echo "4) Ensuring ipykernel is installed..."
pip install ipykernel

echo "5) Installing the Jupyter kernel (name=${KERNEL_NAME}, display=${KERNEL_DISPLAY})..."
# ipython kernel install uses ipykernel's installed tools
python -m ipykernel install --user --name="${KERNEL_NAME}" --display-name "${KERNEL_DISPLAY}"

echo "Setup complete!"
echo
echo "Notes:"
echo " - To keep the venv activated in your current shell, run: source ./setup_bits_dnn_ass1.sh"
echo " - To activate manually later: source ${VENV_DIR}/bin/activate"

