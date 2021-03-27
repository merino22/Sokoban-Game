#include <iostream>
#include <string>
#include <string.h>
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
    unsigned a0 = regs[Register::a0];
    unsigned a1 = regs[Register::a1];
    unsigned a2 = regs[Register::a2];
    unsigned a3 = regs[Register::a3];

    switch (v0)
    {
        case 50:
        {
            if(kbhit())
            {
                regs[Register::v0] = 1;
            }
            else
            {
                regs[Register::v0] = 0;
            }
            return ErrorCode::Ok;
        }
        case 51:
        {
            rlutil::locate(a1, a2);
            return ErrorCode::Ok;
        }
        case 52:
        {
            rlutil::hidecursor();
            return ErrorCode::Ok;
        }
        case 53:
        {
            rlutil::cls();
            return ErrorCode::Ok;
        }
        case 27:
        {
            switch(a0)
            {
                case 32:
                {
                    std::cout << " ";
                    return ErrorCode::Ok;
                }
                case 47:
                {
                    std::cout << "/";
                    return ErrorCode::Ok;
                }
                case 88:
                {
                    std::cout << "X";
                    return ErrorCode::Ok;
                }
                case 92:
                {
                    std::cout << "\\";
                    return ErrorCode::Ok;
                }
                case 95:
                {
                    std::cout << "_";
                    return ErrorCode::Ok;
                }
                case 170:
                {
                    std::cout << "¬";
                    return ErrorCode::Ok;
                }
                case 176:
                {
                    std::cout << "░";
                    return ErrorCode::Ok;
                }
                case 179:
                {
                    std::cout << "│";
                    return ErrorCode::Ok;
                }
                case 185:
                {
                    std::cout << "╣";
                    return ErrorCode::Ok;
                }
                case 186:
                {
                    std::cout << "║";
                    return ErrorCode::Ok;
                }
                case 187:
                {
                    std::cout << "╗";
                    return ErrorCode::Ok;
                }
                case 188:
                {
                    std::cout << "╝";
                    return ErrorCode::Ok;
                }
                case 196:
                {
                    std::cout << "─";
                    return ErrorCode::Ok;
                }
                case 200:
                {
                    std::cout << "╚";
                    return ErrorCode::Ok;
                }
                case 201:
                {
                    std::cout << "╔";
                    return ErrorCode::Ok;
                }
                case 202:
                {
                    std::cout << "╩";
                    return ErrorCode::Ok;
                }
                case 203:
                {
                    std::cout << "╦";
                    return ErrorCode::Ok;
                }
                case 204:
                {
                    std::cout << "╠";
                    return ErrorCode::Ok;
                }
                case 205:
                {
                    std::cout << "═";
                    return ErrorCode::Ok;
                }
                case 206:
                {
                   std::cout << "╬";
                    return ErrorCode::Ok; 
                }
                case 219:
                {
                    std::cout << "█";
                    return ErrorCode::Ok;
                }
                case 220:
                {
                    std::cout << "▄";
                    return ErrorCode::Ok;
                }
                case 228:
                {
                    std::cout << "õ";
                    return ErrorCode::Ok;
                }
                case 248:
                {
                    std::cout << "°";
                    return ErrorCode::Ok;
                }
            }
            return ErrorCode::Ok;
        }
        case 28:
        {
            rlutil::setColor(a0);
            return ErrorCode::Ok;
        }
        case 29:
        {
            rlutil::setBackgroundColor(a0);
            return ErrorCode::Ok;
        }
        case 30:
        {
            rlutil::resetColor();
            return ErrorCode::Ok;
        }
        case 31:
        {
            kbhit();
            regs[Register::v0] = getch();
            return ErrorCode::Ok;
        }
        case 32:
        {
            regs[Register::v0] = getch();
            return ErrorCode::Ok;
        }
        case 39:
        {
            std::cout << " .d8888b.   .d88888b.  888    d8P   .d88888b.  888888b.         d8888 888b    888 " << std::endl;
            std::cout << "d88P  Y88b d88P* *Y88b 888   d8P   d88P* *Y88b 888  *88b       d88888 8888b   888 " << std::endl;
            std::cout << "Y88b.      888     888 888  d8P    888     888 888  .88P      d88P888 88888b  888 " << std::endl;
            std::cout << " *Y888b.   888     888 888d88K     888     888 8888888K.     d88P 888 888Y88b 888 " << std::endl;
            std::cout << "    *Y88b. 888     888 8888888b    888     888 888  *Y88b   d88P  888 888 Y88b888 " << std::endl;
            std::cout << "      *888 888     888 888  Y88b   888     888 888    888  d88P   888 888  Y88888 " << std::endl;
            std::cout << "Y88b  d88P Y88b. .d88P 888   Y88b  Y88b. .d88P 888   d88P d8888888888 888   Y8888 " << std::endl;
            std::cout << " *Y8888P*   *Y88888P*  888    Y88b  *Y88888P*  8888888P* d88P     888 888    Y888 " << std::endl;
            return ErrorCode::Ok;
        }
        case 40:
        {
            std::cout << "Y88b   d88P                     888       888 d8b          " << std::endl;
            std::cout << " Y88b d88P                      888   o   888 Y8P          " << std::endl;
            std::cout << "  Y88o88P                       888  d8b  888              " << std::endl;
            std::cout << "   Y888P  .d88b.  888  888      888 d888b 888 888 88888b.  " << std::endl;
            std::cout << "    888  d88**88b 888  888      888d88888b888 888 888 *88b " << std::endl;
            std::cout << "    888  888  888 888  888      88888P Y88888 888 888  888 " << std::endl;
            std::cout << "    888  Y88..88P Y88b 888      8888P   Y8888 888 888  888 " << std::endl;
            std::cout << "    888   *Y88P*   *Y88888      888P     Y888 888 888  888 " << std::endl;
            return ErrorCode::Ok;
        }
        default:
            if (v0 > 20 && v0 <= 60)
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
