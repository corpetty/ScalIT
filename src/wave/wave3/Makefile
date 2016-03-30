WAVE3PATH := $(SRCPATH)/wave/wave3
include $(PREFIX)/Makefile.setup

.PHONY: all clean

all: wave3jb wave3jb_e wave3jb_o wave3hs  wave3hs_e  wave3hs_o

clean:
	@rm -f *.o

WAVE3_OBJS = $(WAVE3PATH)/module/jacobi/wave3jb.o $(WAVE3PATH)/module/hyperspherical/wave3hs.o $(WAVE3PATH)/hsjb.o

%.o: %.f90
	$(FC) $(FFLAGS) -o $@ -c $^

#--------------- Wave3JB Module --------------------------------
wave3jb: $(WAVE3_OBJS) $(WAVE3PATH)/prog/wave3jb.drv.o
	$(FC) -o $(BINPATH)/wave3/wave3jb $(WAVE3PATH)/prog/wave3jb.drv.o $(WAVE3_OBJS) $(LIBPATH)/libutil.a $(LIBPATH)/libham.a $(SRCPATH)/ham/ja3/index/index_ABC.o $(LDFLAGS)

wave3jb_e: $(WAVE3_OBJS) $(WAVE3PATH)/prog/wave3jb.drv.o
	$(FC) -o $(BINPATH)/wave3/wave3jb_e $(WAVE3PATH)/prog/wave3jb.drv.o $(WAVE3_OBJS) $(LIBPATH)/libutil.a $(LIBPATH)/libham.a $(SRCPATH)/ham/ja3/index/index_AB2e.o $(LDFLAGS)

wave3jb_o: $(WAVE3_OBJS) $(WAVE3PATH)/prog/wave3jb.drv.o
	$(FC) -o $(BINPATH)/wave3/wave3jb_o $(WAVE3PATH)/prog/wave3jb.drv.o $(WAVE3_OBJS) $(LIBPATH)/libutil.a $(LIBPATH)/libham.a $(SRCPATH)/ham/ja3/index/index_AB2o.o $(LDFLAGS)

#--------------------  Wave3HS Module  ---------------------------
wave3hs: $(WAVE3_OBJS) $(WAVE3PATH)/prog/wave3hs.drv.o
	$(FC) -o $(BINPATH)/wave3/wave3hs $(WAVE3PATH)/prog/wave3hs.drv.o $(WAVE3_OBJS) $(LIBPATH)/libutil.a $(LIBPATH)/libham.a $(SRCPATH)/ham/ja3/index/index_ABC.o $(LDFLAGS)

wave3hs_e: $(WAVE3_OBJS) $(WAVE3PATH)/prog/wave3hs.drv.o
	$(FC) -o $(BINPATH)/wave3/wave3hs_e $(WAVE3PATH)/prog/wave3hs.drv.o $(WAVE3_OBJS) $(LIBPATH)/libutil.a $(LIBPATH)/libham.a $(SRCPATH)/ham/ja3/index/index_AB2e.o $(LDFLAGS)

wave3hs_o: $(WAVE3_OBJS) $(WAVE3PATH)/prog/wave3hs.drv.o
	$(FC) -o $(BINPATH)/wave3/wave3hs_o $(WAVE3PATH)/prog/wave3hs.drv.o $(WAVE3_OBJS) $(LIBPATH)/libutil.a $(LIBPATH)/libham.a $(SRCPATH)/ham/ja3/index/index_AB2o.o $(LDFLAGS)
