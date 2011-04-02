UNAME=$(shell uname)
COMPILER=mxmlc
BIN_PATH=bin
BIN_NAME=chuck.swf
BIN=$(BIN_PATH)/$(BIN_NAME)
BROWSER="Firefox.app"
ifeq ($(UNAME), Darwin)
STANDALONE="Flash Player Debugger"
else
STANDALONE=flashplayerdebugger
endif
ENTRY_POINT=src/Main.as

all:
	killall $(STANDALONE) &2>/dev/null ;
	$(COMPILER) -use-network=false $(ENTRY_POINT) -o $(BIN) ;
ifeq ($(UNAME), Darwin)
	open -a $(STANDALONE).app $(BIN) ;
	osascript -e 'tell application "Flash Player Debugger" to set the bounds of the first window to {2000, 400, 2550, 800}' ;
else
	$(STANDALONE) $(BIN) & ;
endif

browser:
	$(COMPILER) $(ENTRY_POINT) -o $(BIN) ;
ifeq ($(UNAME), Darwin)
	open -a $(BROWSER) http://home.jeena.net/~jeena/phyx/$(BIN_PATH)/ ;
else
	xdg-open $(BIN_PATH)/index.html ;
endif

test:
	killall $(STANDALONE) &2>/dev/null ;
	$(COMPILER) src/Test.as -o $(BIN) ;
ifeq ($(UNAME), Darwin)
	open -a $(STANDALONE) $(BIN) ;
	osascript -e 'tell application "Flash Player Debugger" to set the bounds of the first window to {3000, 400, 3550, 800}' ;	
else
	$(STANDALONE) $(BIN) & ;
endif

clean:
	rm $(BIN) ;
