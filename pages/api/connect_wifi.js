import { PythonShell } from 'python-shell';

export default async (req, res) => {
	const { name, password } = req.body;

	const options = {
		mode: 'text',
		// path where python is installed
		pythonPath: process.env.pythonPath,
		scriptPath: process.env.scriptDir,
		args: [name, password]
	};

	PythonShell.run('update_wifi.py', options, function (error, results) {
		if (error) {
			console.log(error);
			res.status(500).json({ error: 'Internal Server Error' });
		}
		else {
			// results is an array consisting of messages printed during execution
			console.log(results);
			res.status(200).json({ message: `Attempting to connect to SSID:${name}. Upon successful connection device will vibrate 3 times. If it fails to connect it will vibrate 1 time for 5 seconds` });
		}
	});
}
