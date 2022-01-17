const { Stack, Duration } = require('aws-cdk-lib');
const lambda = require("aws-cdk-lib/aws-lambda");

class RustCrudStack extends Stack {
  /**
   *
   * @param {Construct} scope
   * @param {string} id
   * @param {StackProps=} props
   */
  constructor(scope, id, props) {
    super(scope, id, props);

    const getUserHandler = new lambda.Function(this, "GetUserHandler", {
      runtime: lambda.Runtime.PROVIDED_AL2, 
      code: lambda.Code.fromAsset("../lambda-functions/get-user/lambda.zip"),
      handler: "handler"
    });

    const createUserHandler = new lambda.Function(this, "CreateUserHandler", {
      runtime: lambda.Runtime.PROVIDED_AL2, 
      code: lambda.Code.fromAsset("../lambda-functions/create-user/lambda.zip"),
      handler: "handler"
    });

    const updateUserHandler = new lambda.Function(this, "UpdateUserHandler", {
      runtime: lambda.Runtime.PROVIDED_AL2, 
      code: lambda.Code.fromAsset("../lambda-functions/update-user/lambda.zip"),
      handler: "handler"
    });

    const deleteUserHandler = new lambda.Function(this, "DeleteUserHandler", {
      runtime: lambda.Runtime.PROVIDED_AL2, 
      code: lambda.Code.fromAsset("../lambda-functions/delete-user/lambda.zip"),
      handler: "handler"
    });

    const api = new apigateway.RestApi(this, "users-api", {
      restApiName: "Users Service",
      description: "This service serves users."
    });

    const getUserIntegration = new apigateway.LambdaIntegration(getUserHandler, {
      requestTemplates: { "application/json": '{ "statusCode": "200" }' }
    });

    api.root.addMethod("GET", getUserIntegration);

    const createUserIntegration = new apigateway.LambdaIntegration(createUserHandler, {
      requestTemplates: { "application/json": '{ "statusCode": "200" }' }
    });

    api.root.addMethod("POST", createUserIntegration);

    const updateUserIntegration = new apigateway.LambdaIntegration(updateUserHandler, {
      requestTemplates: { "application/json": '{ "statusCode": "200" }' }
    });

    api.root.addMethod("PUT", updateUserIntegration);

    const deleteUserIntegration = new apigateway.LambdaIntegration(deleteUserHandler, {
      requestTemplates: { "application/json": '{ "statusCode": "200" }' }
    });

    api.root.addMethod("DELETE", deleteUserIntegration);
  }
}

module.exports = { RustCrudStack }
