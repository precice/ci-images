# Dockerfile for building preCICE on ubuntu 22.04

FROM precice/precice:nightly

RUN git clone --branch v9.3.0 https://gitlab.kitware.com/vtk/vtk.git vtk && \
      cd vtk && \
      mkdir build && \
      cd build && \
      cmake -DVTK_WRAP_PYTHON="ON" -DVTK_USE_MPI="ON" -DCMAKE_BUILD_TYPE=Release .. && \
      cmake --build . -j $(nproc) && \
      cmake --install . && \
      cd ../.. && \
      rm -rf vtk

RUN apt-get -qq update && \
      apt-get install -qq -y python3-pip python3-jinja2 python3-scipy python3-sympy libmetis-dev time && \
      pip install -q --no-input --no-cache-dir --no-python-version-warning polars

RUN echo 'export PYTHONPATH="${PYTHONPATH}:/usr/local/lib/python3.10/site-packages/"' > /etc/profile.d/99-vtk.sh
