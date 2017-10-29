[![Abcdspec-compliant](https://img.shields.io/badge/ABCD_Spec-v1.0-green.svg)](https://github.com/soichih/abcd-spec)

# app-fsurf
BrainLife application to run freesurfer on OSG using fsurf.

As this application uses fsurf, you need to run this on any resource where fsurf credential is installed (~/.fsurf). fsurf itself is shipped with this application, but we download the latest version from `http://stash.osgconnect.net/+fsurf/fsurf`

Please see https://support.opensciencegrid.org/support/solutions/articles/12000008488-setting-up-fsurf-on-your-computer for more info on fsurf

## Intallation

git clone this repo

## Running (locally)
 
Create config.json on current directory.

```
{
	    "t1": "/N/u/hayashis/Karst/testdata/sca-service-freesurfer/t1.nii.gz"
}

```

Point to where you have your T1 anatonmy. It must be defaced and anonymized.

## Running (via BrainLife)

Visit `https://brain-life.org`


## fsurf

```
curl -L -o fsurf 'http://stash.osgconnect.net/+fsurf/fsurf'
chmod +x fsurf

```

