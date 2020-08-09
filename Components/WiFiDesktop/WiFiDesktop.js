import React, { useState } from "react";
import axios from 'axios';
import { makeStyles } from "@material-ui/core/styles";
import Input from "@material-ui/core/Input";
import Button from "@material-ui/core/Button";

const useStyles = makeStyles((theme) => ({
  root: {
    maxWidth: 360,
    backgroundColor: theme.palette.background.paper,
  },
  box: {
    border: "1px ",
    boxShadow: "1px 1px 4px grey",
    backgroundColor: "#f2f2f2",
    borderRadius: "1rem",
    height: "23rem",
    width: "30rem",
    display: "flex",
    flexDirection: "column",
    justifyContent: "space-evenly",
    alignItems: "center",
    [theme.breakpoints.down("sm")]: {
      width: "20rem",
    },
  },
  INPUT: {
    marginLeft: "3rem",
    // '&::-Input::placeholder':{
    //   opacity: 0
    // },
    // '&::Input:focus::placeholder':{
    //   opacity: 1
    // }
  },
  Label: {
    fontFamily: "Segoe UI Semibold",
    marginLeft: "2rem",
    [theme.breakpoints.down("sm")]: {
      marginLeft: "0",
    },
  },
}));

const INIT_STATE = [
  { name: "SSID1" },
  { name: "SSID2" },
  { name: "SSID3" },
  { name: "SSID4" },
  { name: "SSID5" },
];

export default function WiFiDesktop() {
  const [data, setData] = useState([]);
  // const [isClicked, setIsClicked] = useState(false); --> is this needed?

  const classes = useStyles();

  const handleChange = (event) => {
    const { id } = event.target;
    const ssid_name = id.split('-')[0];

    //set password with corresponding ssid in state
    const new_data = data.map((ssid) => {
      return ssid.name === ssid_name
        ? { name: ssid_name, password: event.target.value }
        : { name: ssid.name };
    })

    //clear any other passwords that have been inputted by user
    data.forEach(ssid => {
      if (ssid.name != ssid_name)
        document.getElementById(`${ssid.name}-pwd`).value = '';
    })

    setData(new_data);
  }

  const scanWifi = async () => {
    try {
      const url = `${process.env.baseURL}/api/scan_wifi`;
      const response = await axios.get(url);
      const { ssid_list } = response.data;
      setData(ssid_list);
      document.getElementById('scan-button-container').style.display = 'none';
      document.getElementById('connect-button-container').style.display = 'block';
      document.getElementById('back-button-container').style.display = 'block';
    }
    catch (error) {
      console.log(error);
    }
  };

  const backToScan = () => {
    setData([]);
    document.getElementById('scan-button-container').style.display = 'block';
    document.getElementById('connect-button-container').style.display = 'none';
    document.getElementById('back-button-container').style.display = 'none';
  }

  const connectWifi = async () => {
    try {
      const ssid = [];
      for (let i = 0; i < data.length; i++) {
        if (data[i].password) {
          ssid.push(data[i].name);
          ssid.push(data[i].password);
        }
      }

      if(ssid.length == 0) {
        alert('You did not enter a password for any SSID.');
        return;
      }

      const url = `${process.env.baseURL}/api/connect_wifi`;
      const payload = { name: ssid[0], password: ssid[1] };
      const response = await axios.post(url, payload);
      alert(response.data.message);
    }
    catch (error) {
      console.log(error);
    }
  }

  // const Clicked = (name, password) => {
  //   const newData = data.map((wifi) => {
  //     return wifi.name === name
  //       ? { placeholder: "Enter Password", name, password }
  //       : { name: wifi.name };
  //   })
  //   setData(newData);
  // }

  // const UnClicked = (name, password) => {
  //   const newData = data.map((wifi) => {
  //     return wifi.name === name
  //       ? { placeholder: "", name }
  //       : { name: wifi.name };
  //   });
  //   setData(newData);
  // };

  return (
    <div className={classes.box}>
      {
        data.map((ssid, key) => (
          <div
            style={{
              borderBottom: '1px solid',
              width: '80%',
              display: 'flex',
              justifyContent: 'space-between',
              position: 'relative'
            }}
            key={key}
          >
            <div id={`${ssid.name}-label`} className={classes.Label}>
              {ssid.name}
            </div>
            <div style={{ position: 'absolute', top: '-4px', left: '35%' }}>
              <Input
                id={`${ssid.name}-pwd`}
                className={classes.INPUT}
                disableUnderline={true}
                placeholder="Enter Password"
                onChange={handleChange}
              />
            </div>
          </div>
        ))
      }

      <div id="scan-button-container">
        <Button
          onClick={scanWifi}
          style={{
            width: "14rem",
            width: "14rem",
            color: "#7e7e7e",
            fontFamily: "Segoe UI Semibold",
          }}
          variant="contained"
        >
          SCAN
        </Button>
      </div>

      <div id="connect-button-container" style={{ display: 'none' }}>
        <Button
          onClick={connectWifi}
          style={{
            width: "14rem",
            width: "14rem",
            color: "#7e7e7e",
            fontFamily: "Segoe UI Semibold",
          }}
          variant="contained"
        >
          CONNECT
        </Button>
      </div>

      <div id="back-button-container" style={{ display: 'none' }}>
        <Button
          onClick={backToScan}
          style={{
            width: "14rem",
            width: "14rem",
            color: "#7e7e7e",
            fontFamily: "Segoe UI Semibold",
          }}
          variant="contained"
        >
          BACK
        </Button>
      </div>

    </div>
  );
}
