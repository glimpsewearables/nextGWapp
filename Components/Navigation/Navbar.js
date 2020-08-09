import React from "react";
import { makeStyles } from "@material-ui/core/styles";
import Paper from "@material-ui/core/Paper";
import Grid from "@material-ui/core/Grid";
import Router from "next/router";

const useStyles = makeStyles((theme) => ({
  root: {
    flexGrow: 1,
  },
  grid: {
    display: "flex",
    flexDirection: "column",
    [theme.breakpoints.down("xs")]: {
      flexDirection: "row",
    },
  },
  paper: {
    padding: theme.spacing(2),
    height: "5rem",
    width: "4rem",
    backgroundColor: "#d6d6d6",
    borderRadius: "20px",
    boxShadow: "4px 2px 11px grey",
    cursor: "pointer",
    [theme.breakpoints.down("xs")]: {
      padding: theme.spacing(4),
    },
  },
  WiFiDesk: {
    padding: theme.spacing(2),
    height: "5rem",
    width: "4rem",
    backgroundColor: "#d6d6d6",
    borderRadius: "20px",
    boxShadow: "4px 2px 11px grey",
    cursor: "pointer",
    [theme.breakpoints.down("xs")]: {
      display: "none",
    },
  },
  WiFiMob: {
    padding: theme.spacing(2),
    height: "5rem",
    width: "4rem",
    display: "none",
    backgroundColor: "#d6d6d6",
    borderRadius: "20px",
    boxShadow: "4px 2px 11px grey",
    cursor: "pointer",
    [theme.breakpoints.down("xs")]: {
      padding: theme.spacing(4),
      display: "block",
    },
  },
  Img: {
    height: "5rem",
    width: "4rem",
  },
  Centerbox: {
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
  },
}));

export default function Navbar() {
  const classes = useStyles();

  return (
    <div className={classes.root}>
      <Grid className={classes.grid} container spacing={3}>
        <Grid className={classes.Centerbox} item xs={6} sm={12}>
          <Paper className={classes.WiFiDesk}>
            <img
              className={classes.Img}
              src="/wifi_vectorized.png"
              alt="WiFi Logo"
            />
          </Paper>
          <Paper
            onClick={() => Router.push("/WiFi")}
            className={classes.WiFiMob}
          >
            <img
              className={classes.Img}
              src="/wifi_vectorized.png"
              alt="WiFi Logo"
            />
          </Paper>
        </Grid>
        <Grid className={classes.Centerbox} item xs={6} sm={12}>
          <Paper className={classes.paper}></Paper>
        </Grid>
        <Grid className={classes.Centerbox} item xs={6} sm={12}>
          <Paper className={classes.paper}></Paper>
        </Grid>
        <Grid className={classes.Centerbox} item xs={6} sm={12}>
          <Paper className={classes.paper}></Paper>
        </Grid>
      </Grid>
    </div>
  );
}
