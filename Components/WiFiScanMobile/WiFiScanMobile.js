import axios from 'axios';
import React, { useState } from 'react';
import { makeStyles } from '@material-ui/core/styles';
import List from '@material-ui/core/List';
import ListItem from '@material-ui/core/ListItem';
import ListItemText from '@material-ui/core/ListItemText';
import Button from '@material-ui/core/Button';
import Container from '@material-ui/core/Container';
import Router from 'next/router';

const useStyles = makeStyles((theme) => ({
  root: {
    width: '100%',
    backgroundColor: '#f2f2f2',
    boxShadow: '8px 7px 14px grey',
    borderRadius: '1rem'
  },
  item: {
    margin: '1.2rem',
  },
  button: {
    width: '100%',
    marginBottom: '1rem',
    backgroundColor: '#d8d8d8',
    marginTop: '-0.5rem',
    borderRadius: '0.5rem',
    boxShadow: '0 11px 15px -10px black',
    fontFamily: 'Segoe UI Semibold',
    fontSize: '20px',
    color: '	#7e7e7e',
  }
}));
let data = [
  { name: 'SSID1' },
  { name: 'SSID2' },
  { name: 'SSID3' },
  { name: 'SSID4' },
  { name: 'SSID5' },
];
export default function WiFiScanMobile() {
  const classes = useStyles();
  const [data, setData] = useState([]);

  const scanWifi = async () => {
    try {
      //store this url in an env file
      const url = `${process.env.baseURL}/api/scan_wifi`;
      const response = await axios.get(url);
      const { ssid_list } = response.data;
      setData(ssid_list);
    }
    catch (error) {
      console.log(error);
    }
  };

  return (
    <Container>
      <h1 style={{ color: '#7e7e7e', fontWeight: 'bold', fontFamily: 'Segoe UI ' }}>WiFi</h1>
      <List component="nav" className={classes.root}>
        <Button onClick={scanWifi} className={classes.button}>Scan</Button>
        {data.map((ssid, key) => (
          <ListItem onClick={() => Router.push({ pathname: '/WiFi/Connect', query: { ssid: ssid.name } })} button divider>
            <ListItemText className={classes.item}><span style={{ fontFamily: 'Segoe UI Semibold' }}>{ssid.name}</span></ListItemText>
          </ListItem>
        ))}
      </List>
    </Container>
  );
}
