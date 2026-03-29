#!/usr/bin/env bash
set -euo pipefail

VENV_DIR=".bits-drl-ass1"
KERNEL_NAME=".bits-drl-ass1"
FREEZE_FILE="requirements.txt"

# Check venv exists
if [ ! -d "${VENV_DIR}" ]; then
    echo "ERROR: ${VENV_DIR} not found."
    exit 1
fi

echo "1) Activating virtualenv ${VENV_DIR}..."
source "${VENV_DIR}/bin/activate"

echo "2) Freezing installed packages to ${FREEZE_FILE}..."
pip freeze > "${FREEZE_FILE}"
echo " - Freeze saved to ${FREEZE_FILE}"

echo "3) Deactivating virtualenv..."
deactivate

echo "4) Removing Jupyter kernel named: ${KERNEL_NAME}..."

if jupyter kernelspec list | grep -q "${KERNEL_NAME}"; then
    jupyter kernelspec uninstall -f "${KERNEL_NAME}"
    echo " - Kernel removed."
else
    echo " - Kernel not found."
fi

echo "5) Deleting virtualenv directory ${VENV_DIR}..."
rm -rf "${VENV_DIR}"

echo "Teardown complete ✅"

