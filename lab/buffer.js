// Buffering Tests

var input = [
	"0087Dies ist ein Songt", 
	"ext. Hallo mein Sch", 
	"atz, ich liebe D", 
	"ich, du bist di", 
	"e einzige f", "ür mich!",
	"0034Dies ist der z",
	"weite Teil des Tests"
];

var buffer = "";
var streamLength = 0;
var counter = 0;

var lb = 4;

function onData()
{
	data = input[counter];

	console.log("- onData: " + data);

	if(buffer == "")
        {
		streamLength = parseInt(data.substr(0, lb), 10);
		data = data.substr(lb);
		
		if(streamLength == data.length)
		{
			processData(data);
			streamLength = 0;
		}
		else if(streamLength > data.length)
		{
			buffer = data;
		}
        }
	else 
	{
	    var length = buffer.length + data.length;
		if((length) == streamLength)
		{
			processData(buffer + data);
			streamLength = 0;
			buffer = "";
		}
		else if (length > streamLength)
		{
		    var p = length - streamLength;
		    processData(buffer + data.substr(0, p));
		    buffer = data.substr(p, data.length);
		}
		else
		{
			buffer += data;
		}
	}

	counter++;
	if(input[counter]) setTimeout(onData, 300);
}

function processData(str)
{
	console.log("\n  => processing: " + str + "\n");
}


onData();
