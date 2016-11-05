PROJ_ROOT = $(realpath ./)

TARGET   = hoge
CC       = g++
CXXFLAGS =
LDFLAGS  =
INCDIR   = -I$(PROJ_ROOT)/include
LIBDIR   = -L$(PROJ_ROOT)/lib
LIBS     = -lpiyo

SRCS     = main.cpp
OBJS     = $(SRCS:.cpp=.o)

$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBDIR) $(LIBS)

.cpp.o:
	$(CC) $(CXXFLAGS) -c $^ $(INCDIR)

.PHONY: clean

clean:
	$(RM) $(TARGET) $(OBJS)
