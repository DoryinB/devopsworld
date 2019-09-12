FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS buildStage
#not a url - WHICH ENVIRONMENT WE NEED TO HAVE only need web development (if everything sdk) -- runtime as tools needed for the application to run
WORKDIR /aspnet
#working directory -- in this environment this is where the application will exist
COPY ["devopsworld.Client/devopsworld.Client.csproj", "devopsworld.Client/"] 
#copys stuff from physical machine and bring them to the working dir in the environment
RUN dotnet restore "devopsworld.Client/devopsworld.Client.csproj"
#after downloading the references/packages from project copy everything else
COPY . .
#grab everyhitng  TO everything(current dir)
WORKDIR /aspnet/devopsworld.Client
RUN dotnet build "devopsworld.Client.csproj" -c Release -o /app
#dont care about anyting other than client and build client <and every other csproj referenced by client>
#-c Release -o /app configuration -release(not debug[defualt]) -o output

FROM buildStage AS publishStage
RUN dotnet publish "devopsworld.Client.csproj" --no-restore -c Release -o /app
#named environmnet that doesnt exist ->  no restoe--> we built so all the packages are available so dont rebuild/re-restore
#restore-> has the runtime application for project. packaged & Ready for distribution

FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 AS baseStage 
WORKDIR /deployStage
#EXPOSE 80
COPY --from=publishStage /app .
#go to app directory within current dir COPY everything within it 
CMD [ "dotnet", "devopsworld.Client.dll"]
#we need just content of app directory to be published
#in the runtime create dir

# FROM base AS final
# WORKDIR /app
# COPY --from=publish /app .
# ENTRYPOINT ["dotnet", "devopsworld.Client.dll"]


#in command line?? docker image build --file Dockerfile --tage devopsdemo ./
# docker tag local-image:tagname new-repo:tagname
# docker push new-repo:tagname
