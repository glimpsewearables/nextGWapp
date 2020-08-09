import { PythonShell } from 'python-shell';

export default async (req, res) => {
	const options = {
		mode: 'text',
		pythonPath: process.env.pythonPath,
		scriptPath: process.env.scriptDir,
	};

	PythonShell.run('scan_wifi.py', options, function (error, results) {
		if (error) {
			console.log(error);
			res.status(500).json({ error: 'Internal Server Error' });
		}
		else {
			// results is an array consisting of messages printed during execution
			console.log(results);
			const ssid_list = results.map(ssid => { return { name: ssid } });
			res.status(200).json({ ssid_list });
		}
	});
}