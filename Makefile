COMPILER=mxmlc
BIN_PATH=bin
BIN_NAME=chuck.swf
BIN=$(BIN_PATH)/$(BIN_NAME)
BROWSER="Firefox.app"
STANDALONE="Flash Player Debugger.app"
ENTRY_POINT=src/Main.as

all:
	osascript -e 'tell application "Flash Player Debugger" to quit' ;
	$(COMPILER) -use-network=false $(ENTRY_POINT) -o $(BIN) ;
	open -a $(STANDALONE) $(BIN) ;
	osascript -e 'tell application "Flash Player Debugger" to set the bounds of the first window to {3000, 400, 3550, 800}' ;

browser:
	$(COMPILER) $(ENTRY_POINT) -o $(BIN) ;
	open -a $(BROWSER) http://home.jeena.net/~jeena/phyx/$(BIN_PATH)/ ;

test:
	osascript -e 'tell application "Flash Player Debugger" to quit' ;
	$(COMPILER) src/Test.as -o $(BIN) ;
	open -a $(STANDALONE) $(BIN) ;
	osascript -e 'tell application "Flash Player Debugger" to set the bounds of the first window to {3000, 400, 3550, 800}' ;	

clean:
	rm $(BIN)
