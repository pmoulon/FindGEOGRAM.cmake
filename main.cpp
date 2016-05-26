// Copyright (c) 2016 Pierre MOULON.

// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

#include <geogram/basic/common.h>
#include <geogram/basic/logger.h>
#include <geogram/basic/command_line.h>
#include <geogram/basic/command_line_args.h>
#include <geogram/basic/stopwatch.h>
#include <geogram/basic/file_system.h>
#include <geogram/mesh/mesh.h>
#include <geogram/mesh/mesh_io.h>
#include <algorithm>

int main(int argc, char** argv) {
    using namespace GEO;

    GEO::initialize();

    try {

        Stopwatch Wtot("Total time");

        std::vector<std::string> filenames;

        if(
            !CmdLine::parse(
                argc, argv, filenames, "pointsfile"
            )
        ) {
            return 1;
        }

        const std::string points_filename = filenames[0];

        Logger::div("Data I/O");

        Mesh M_in;

        {
            MeshIOFlags flags;
            flags.reset_element(MESH_FACETS);
            flags.reset_element(MESH_CELLS);
            if(!mesh_load(points_filename, M_in, flags)) {
                return 1;
            }
        }
        std::cout << M_in.vertices.nb() << " vertices loaded" << std::endl;
        
    }
    catch(const std::exception& e) {
        std::cerr << "Received an exception: " << e.what() << std::endl;
        return 1;
    }

    Logger::out("") << "Everything OK, Returning status 0" << std::endl;
    return 0;
}

