#include <iostream>
#include <easm.h>
#include "rlutil.h"
#include <algorithm>
#include <cstdlib>
#include <cstdio>
#include <ctime>

#define waitkey rlutil::anykey("Press any key to continue...\n")

extern "C" ErrorCode handleSyscall(uint32_t *regs, void *mem, MemoryMap *mem_map)
{
    unsigned v0 = regs[Register::v0];

    switch (v0)
    {
        case 20:
        {
            int a0 = regs[Register::a0];
            int a1 = regs[Register::a1];
            regs[Register::v0] = a0 + a1;
            return ErrorCode::Ok;
        }
        case 25:
        {
            int a0 = regs[Register::a0];
            int a1 = regs[Register::a1];
            regs[Register::v0] = a0 * a1;
            return ErrorCode::Ok;
        }
        case 22:
        {
            rlutil::saveDefaultColor();

	        std::cout << "Welcome to rlutil test program." << std::endl;
	        waitkey;

	        std::cout << "\nTest 1: Colors" << std::endl;
	        for (int i = 0; i < 16; i++) {
		        rlutil::setColor(i);
		        std::cout << i << " ";
	        }
            rlutil::resetColor();
            std::cout << std::endl << "You should see numbers 0-15 in different colors." << std::endl;
            waitkey;
            return ErrorCode::Ok;
        }
        case 23:
        {
            std::cout << "\nTest 2: Background colors\n";
	        for (int i = 0; i < 8; i++) {
                rlutil::setBackgroundColor(i);
                std::cout << i;
                rlutil::setBackgroundColor(0);
                std::cout << ' ';
	        }
            rlutil::resetColor();
            std::cout << "\nYou should see numbers 0-7 in different-colored backgrounds.\n";
            waitkey;
            return ErrorCode::Ok;
        }
        case 24:
        {
        	int x = 7; int y = 7; unsigned int cnt = 0;
            rlutil::hidecursor();
            rlutil::cls();
            std::cout << "Test 8: Non-blocking keyboard input" << std::endl;
            std::cout << "You should be able to move the '@' character with WASD keys." << std::endl;
            std::cout << "Hit Space to continue to the next test." << std::endl;
            std::cout << "Turn count: " << cnt << std::endl;
            rlutil::locate(x,y); std::cout << '@' << std::endl; // Output player
            while (true) {
                rlutil::locate(1,4); std::cout << "Turn count: " << cnt;
                if (kbhit()) {
                    char k = getch(); // Get character
                    rlutil::locate(x,y); std::cout << " "; // Erase player
                    if (k == 'a') --x;
                    else if (k == 'd') ++x;
                    else if (k == 'w') --y;
                    else if (k == 's') ++y;
                    else if (k == ' ') break;
                    rlutil::locate(x,y); std::cout << '@'; // Output player
                }
                cnt++;
                std::cout.flush();
            }
            rlutil::showcursor();
            return ErrorCode::Ok;
        }
        default:
            if (v0 > 20 && v0 <= 50)
            {
                std::cout << "Syscall: " << v0 << '\n' << std::flush;
                return ErrorCode::Ok;
            }
            else
            {
                return ErrorCode::SyscallNotImplemented;
            }
    }
}