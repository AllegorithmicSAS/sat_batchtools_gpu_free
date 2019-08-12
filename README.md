# SAT's Batchtools without gpu. 
By default, some of batchtools like sbsbaker need a graphics context, in consequence, they can't be runnable on a CPU farm.   

To overcome this problem, we provided a docker file which embeds a virtual X server (xvfb) and all needed dependencies. With this workaround, it will be possible to use SAT's batchtools without GPU.

On your server or farm's slave follow this procedure: 

### Docker
Docker is a software service which delivers containers. Containers allow you to run an application in
a virtual system. 
It's an opensource project and you can get it from https://www.docker.com/ or directly from your
package manager. 

Centos installation : 
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-centos-7
In summary:
```buildoutcfg
sudo yum check-update
curl -fsSL https://get.docker.com/ | sh
sudo systemctl start docker
sudo systemctl enable docker
```

Ubuntu installation :
https://docs.docker.com/install/linux/docker-ce/ubuntu/
In summary:
```buildoutcfg
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

Windows installation:
https://docs.docker.com/docker-for-windows/install/

Once everything is correctly installed and the service started. We can go through the building
 of SAT's docker file.
 
### SAT's Dockerfile
First download the repository and change dir: 
```buildoutcfg
git clone https://github.com/AllegorithmicSAS/sat_batchtools_gpu_free.git
cd sat_batchtools_gpu_free
chmod +x ./sat_docker.sh
```

Next build the docker image (don't forget the dot at the end):
```buildoutcfg
docker build -t sat .
```
Docker building the SAT's image, after all the verbose ouput if everything goes well you can see the result with:
```buildoutcfg
docker images -a
```
And found a sat image in the list. 
```buildoutcfg
REPOSITORY          TAG                 IMAGE ID            CREATED              SIZE
<none>              <none>              0f30ba61d936        About a minute ago   360MB
sat                 latest              f35ce67e8ad0        About a minute ago   360MB
<none>              <none>              407943a64c6f        About a minute ago   360MB
<none>              <none>              449d5b0291fd        About a minute ago   360MB
...
```

Now docker is ready to create a SAT container. To simplify the use we provied a script which wrap the docker command. 


### sat_docker.sh
sat_docker.sh is a command line to simplify the use of SAT's batchtools with docker. It has few option flags:
```buildoutcfg
-exe [FILE]                   Full path of a batchtool executable, e.g /opt/sat2019.1.2/sbsbaker
-inputdir [DIR]               Full path of the input directory, e.g /project/meshes/foo
-outputdir [DIR]              Full path of the ouput directory, e.g /project/baked_maps/foo
-options ["STRING"]           All batchtool option (borned by quotation marks), e.g "position-from-mesh --inputs /inputdir/foo.fbx --highdef-mesh /inputdir/bar.fbx --output-path /outputdir"
-user=1000:1000 [USER]        Precise the user who run the docker process and write output files, by default it's the current user 1000:1000
-help                         Display help
```

An example of how to use it:
```buildoutcfg
./sat_docker.sh -exe /opt/sat/sbsbaker -inputdir /project/export/mesh -outputdir /project/export/bakedmaps -options "position-from-mesh --inputs /inputdir/foo_mesh.fbx --highdef-mesh /inputdir/foo_mesh-hi.fbx --output-path /outputdir"
```

Be careful! be sure to use the path **/inputdir and outputdir/** in the options flags. They correspond to the mapped volumes of docker.

Don't care to this output. 
```buildoutcfg
_XSERVTransmkdir: ERROR: euid != 0,directory /tmp/.X11-unix will not be created.
```
