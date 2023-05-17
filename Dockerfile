# Base image

FROM microsoft/dotnet:3.1-aspnetcore-runtime

# Set the working directory in the container

WORKDIR /app

# Copy the contents of the Umbraco web application to the container

COPY . .

# Expose the port that Umbraco will run on (default is 80)

EXPOSE 80

# Set the entry point for the container

ENTRYPOINT ["dotnet", "Umbraco.Cms.Web.dll"]
